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
    """
    Like *argparse.ArgumentParser*, but prints help when no arguments.
    """

    def error(self, message):
        """
        Print error message, then help.
        """
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class ComputeOptimalSampleSize():
    """
    Wrapper class to allow functions to reference each other.
    """

    def ExistingFile(self, fname):
        """
        Return *fname* if existing file, otherwise raise ValueError.
        """
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)
        
    def WhichEpoch(self, epoch_time_array, current_time):
        """
        Return the index of the epoch that contains *current_time*.
        """
        max_index = 0
        for i in range(len(epoch_time_array)):
            if current_time >= epoch_time_array[i]:
                max_index = i
        return max_index
    
    def ComputeCoalescentTime(self, sample_size, population_size):
        """
        Return the coalescent time for a given sample size and population size.
        """
        # The coalescent time is given by the formula:
        # T_k = (k choose 2) / (2 * N)
        # where k is the sample size and N is the population size.
        return (2 * population_size) / math.comb(sample_size, 2)
    
    def ComputeCoalescentTree(self, sample_size, epoch_time_array, epoch_population_array):
        """
        Return the coalescent tree for a given sample size and demographic history.
        """
        # Initialize the coalescent tree
        coalescent_tree = []
        # Iterate through the epochs in reverse order
        current_time = 0
        for i in reversed(range(2, sample_size + 1)):
            # Get the current epoch time and population size
            this_epoch = self.WhichEpoch(epoch_time_array, current_time)
            this_pop = epoch_population_array[this_epoch]
            # Compute the coalescent time for this sample size and population size
            this_coalescent_time = self.ComputeCoalescentTime(i, this_pop)
            # Append the coalescent time to the tree
            coalescent_tree.append((current_time, this_coalescent_time, this_pop))
            # Update the current time
            current_time += this_coalescent_time
        return coalescent_tree

    def expected_gr(self, input_df, r):
        """
        Compute E[G_r] from a given coalescent interval table and specified r.
        """
        n = len(df)  # max sample size = number of intervals
        if not (1 <= r <= n - 1):
            raise ValueError(f"r must be between 1 and n-1 (got r={r}, n={n})")
        
        numerator_sum = 0
        for k in range(2, n - r + 2):  # inclusive of n - r + 1
            binom_term = comb(n - k, r - 1)
            N_k = df.iloc[k - 1, 2]  # k - 1 because pandas is 0-indexed
            numerator_sum += binom_term * N_k

        denominator = r * comb(n - 1, r)
        return numerator_sum / denominator


    def ComputeOptimalSampleSizeParser(self):
        """
        Return *argparse.ArgumentParser* for ``fitdadi_infer_DFE.py``.
        """
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
        """
        Execute main function.
        """
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
        output_tree_file = '{0}{1}output_tree.csv'.format(args['outprefix'], underscore)
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
        coalescent_intervals = [self.ComputeCoalescentTime(2, epoch_population[-1])]
        population_intervals = [epoch_population[-1]]
        notFoundOptimalSampleSize = True
        k = 2
        this_coalescent_tree = self.ComputeCoalescentTree(
            k, epoch_time, epoch_population
        )
        # Edge case of k = 2
        if target_time >= max(coalescent_intervals):
            optimal_sample_size = 2
            notFoundOptimalSampleSize = False
            logger.info('Optimal sample size is {}.'.format(optimal_sample_size))
        # Loop until the optimal sample size is found
        while(notFoundOptimalSampleSize):
            # Update coalescent intervals and population intervals
            # total_time = [element[0] for element in this_coalescent_tree]
            coalescent_intervals = [element[1] for element in this_coalescent_tree]
            population_intervals = [element[2] for element in this_coalescent_tree]
            # Check standard case of median of coalescent intervals
            # Check if the target time is in the range of coalescent intervals
            # print(total_time)
            median_position = int(len(coalescent_intervals) / 2) + 1
            median_time = sum(coalescent_intervals[0:median_position])
            if target_time > median_time:
                optimal_sample_size = k
                # print(coalescent_intervals)
                # print(population_intervals)
                notFoundOptimalSampleSize = False
            # If previous checks fail, then append more coalescent intervals
            # and increase k
            median_time = sum(coalescent_intervals[0:median_position])
            k += 1
            del this_coalescent_tree
            # print('this is a test')
            this_coalescent_tree = self.ComputeCoalescentTree(
                k, epoch_time, epoch_population)
            if (k % 100 == 0):
                logger.info("Optimal sample size is greater than {0}.".format(k))
                logger.info("Contemporary median time is {0}".format(median_time))
        logger.info('Optimal sample size is {}.'.format(optimal_sample_size))
        logger.info('Outputting coalescent tree computed at optimal sample size.')
        output_tree = pd.DataFrame(
            this_coalescent_tree, 
            columns=['Total time', 'Next time interval', 'Population size'])
        output_tree.to_csv(output_tree_file, index=False)
        
        # Compute expected site frequency spectrum (sfs)
        logger.info('Computing expected sfs for optimal sample size of {}.'.format(
            optimal_sample_size))
        
        output_sfs = []
        for r in range(1, optimal_sample_size + 1):
            expected_gr = self.expected_gr(output_tree, r)
            logger.info('E[G_{}] = {}'.format(r, expected_gr))
            output_sfs.append(expected_gr)
        # Write out the expected sfs
        output_sfs = dadi.Spectrum(output_sfs, 
                                   mask=np.zeros(optimal_sample_size, 
                                                 dtype=bool))
        output_sfs.to_file(expected_sfs)


if __name__ == '__main__':
    ComputeOptimalSampleSize().main()
