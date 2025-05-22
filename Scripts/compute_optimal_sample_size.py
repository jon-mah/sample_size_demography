""" Given a demographic history and a target time, compute the optimal sample
size to recover the evolutionary signal of that time.

JCM 20250521
"""


import sys
import os
import logging
import time
import argparse
import warnings

import numpy as np
import dadi
import scipy.stats.distributions
import scipy.integrate
import scipy.optimize
import pandas as pd
import math


class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class ComputeOptimalSampleSize():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)
        
    def WhichEpoch(self, epoch_time_array, current_time):
        """Return the index of the epoch that contains *current_time*."""
        for i in range(len(epoch_time_array)):
            if current_time < epoch_time_array[i]:
                return i
        return len(epoch_time_array) - 1
    
    def ComputeCoalescentTime(self, sample_size, population_size):
        """Return the coalescent time for a given sample size and population size."""
        # The coalescent time is given by the formula:
        # T_k = (k choose 2) / (2 * N)
        # where k is the sample size and N is the population size.
        return math.comb(sample_size, 2) / (2 * population_size)

    def ComputeOptimalSampleSizeParser(self):
        """Return *argparse.ArgumentParser* for ``fitdadi_infer_DFE.py``."""
        parser = ArgumentParserNoArgHelp(
            description=(
                'Given the number of individuals in population one and two, '
                'this script outputs a `*pops_file.txt` in the format '
                'specified for use by the python package, `easySFS.py`.'),
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument(
            'input_demography', type=self.ExistingFile,
            help='A `.csv` file describing the demographic history.')
        parser.add_argument(
            'target_time', type=float,
            help='The target time to recover the evolutionary signal.')
        parser.add_argument(
            '--nu_tau', dest='nu_tau',
            help=('Boolean flag for input file type.'),
            action='store_true')
        parser.set_defaults(nu_tau=False)
        parser.add_argument(
            'outprefix', type=str,
            help='The file prefix for the output files')
        return parser

    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.ComputeOptimalSampleSizeParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
        outprefix = args['outprefix']
        input_demography = args['input_demography']
        target_time = args['target_time']
        nu_tau = args['nu_tau']

        # Numpy options
        np.set_printoptions(linewidth=np.inf)

        # create output directory if needed
        outdir = os.path.dirname(args['outprefix'])
        if outdir:
            if not os.path.isdir(outdir):
                if os.path.isfile(outdir):
                    os.remove(outdir)
                os.mkdir(outdir)

        # Output files: logfile
        # Remove output files if they already exist
        underscore = '' if args['outprefix'][-1] == '/' else '_'
        expected_sfs = \
           '{0}{1}expected_sfs.txt'.format(
                args['outprefix'], underscore)
        logfile = '{0}{1}log.log'.format(args['outprefix'], underscore)
        to_remove = [logfile]
        for f in to_remove:
            if os.path.isfile(f):
                os.remove(f)

        # Set up to log everything to logfile.
        logging.shutdown()
        logging.captureWarnings(True)
        logging.basicConfig(
            format='%(asctime)s - %(levelname)s - %(message)s',
            level=logging.INFO)
        logger = logging.getLogger(prog)
        warning_logger = logging.getLogger("py.warnings")
        logfile_handler = logging.FileHandler(logfile)
        logger.addHandler(logfile_handler)
        warning_logger.addHandler(logfile_handler)
        formatter = logging.Formatter(
            '%(asctime)s - %(levelname)s - %(message)s')
        logfile_handler.setFormatter(formatter)
        logger.setLevel(logging.INFO)

        # print some basic information
        logger.info('Beginning execution of {0} in directory {1}\n'.format(
            prog, os.getcwd()))
        logger.info('Progress is being logged to {0}\n'.format(logfile))
        logger.info('Parsed the following arguments:\n{0}\n'.format(
            '\n'.join(['\t{0} = {1}'.format(*tup) for tup in args.items()])))

        # Read in the demographic history
        logger.info('Reading in the demographic history from {0}'.format(
            input_demography))
        input_demography = pd.read_csv(input_demography, header=None)
        epoch_time = input_demography[0].values
        epoch_population = input_demography[1].values

        # Find optimal sample size
        # Initialize array of tuples of (time, population size)
        logger.info('Finding optimal sample size for inference of ' \
            'evolutionary signal in target time {0}'.format(target_time))
        coalescent_intervals = [self.ComputeCoalescentTime(2, epoch_population[0])]
        population_intervals = [epoch_population[0]]
        notFoundOptimalSampleSize = True
        k = 2
        while(notFoundOptimalSampleSize):
            # Check edge case of k=2 being optimal sample size
            if target_time < coalescent_intervals[0]:
                optimal_sample_size = 2
                notFoundOptimalSampleSize = False
                logger.info('Optimal sample size is {}.'.format(optimal_sample_size))
            # Check starndard case of median of coalescent intervals
            # Check if the target time is in the range of coalescent intervals
            median_interval_position_1 = int(len(coalescent_intervals) / 2)
            median_interval_position_2 = int((len(coalescent_intervals) / 2) + 1)
            if target_time > coalescent_intervals[median_interval_position_1] and \
               target_time < coalescent_intervals[median_interval_position_2]:
                # Note that median_interval_2 is the next interval and thus
                # is guaranteed to include the target time
                optimal_sample_size = median_interval_position_2
                notFoundOptimalSampleSize = False
                logger.info('Optimal sample size is {}.'.format(optimal_sample_size))
            # If previous checks fail, then append more coalescent intervals
            # and increase k
            k = k + 1
            # Append the coalescent time for the next sample size
            coalescent_intervals.append(
                self.ComputeCoalescentTime(k, 
                    epoch_population[self.WhichEpoch(epoch_time, 
                                                     coalescent_intervals[-1])])
            )
            population_intervals.append(
                epoch_population[self.WhichEpoch(epoch_time, 
                                                  coalescent_intervals[-1])]
            )
        logger.info('Optimal sample size is {}.'.format(optimal_sample_size))
        # Write out the expected sfs
        logger.info('Computing expected sfs for optimal sample size of {}.'.format(
            optimal_sample_size))

if __name__ == '__main__':
    ComputeOptimalSampleSize().main()
