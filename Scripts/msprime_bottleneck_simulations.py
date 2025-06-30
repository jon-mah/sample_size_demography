""" Uses MSPrime to simulate bottleneck demographic scenarios.

JCM 20250625
"""


import sys
import os
import logging
import time
import argparse
import warnings

import msprime


class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class msPrimeSimulate():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)

    def msPrimeSimulateParser(self):
        """Return *argparse.ArgumentParser* for ``fitdadi_infer_DFE.py``."""
        parser = ArgumentParserNoArgHelp(
            description=(
                'Given the number of individuals in population one and two, '
                'this script outputs a `*pops_file.txt` in the format '
                'specified for use by the python package, `easySFS.py`.'),
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument(
            'sample_size', type=int,
            help='An integer indexing the sample size.')
        parser.add_argument(
            'replicate', type=int,
            help='An integer indexing the replicate.')
        parser.add_argument(
            'outprefix', type=str,
            help='The file prefix for the output files')
        return parser

    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.msPrimeSimulateParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
        sample_size = args['sample_size']
        replicate = args['replicate']
        outprefix = args['outprefix']

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
        logfile = '{0}{1}log.log'.format(args['outprefix'], underscore)
        output_ThreeEpB_1000 = '{0}{1}ThreeEpochBottleneck_1000_1000_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_2000 = '{0}{1}ThreeEpochBottleneck_2000_2000_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
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

        # Initialize demography object
        dem0 = msprime.Demography()
        dem1 = msprime.Demography()
        # Three epoch ancient bottleneck, population 4
        dem0.add_population(name="ThreeEpB_1000", 
            description="Three epcoh bottleneck, 1000, 1000", initial_size=50000)
        dem1.add_population(name="ThreeEpB_2000", 
            description="Three epcoh bottleneck, 2000, 2000", initial_size=50000)

        # Demographic events
        dem0.add_population_parameters_change(time=1000, initial_size=1000, population=0)
        dem0.add_population_parameters_change(time=2000, initial_size=10000, population=0)
        dem1.add_population_parameters_change(time=2000, initial_size=1000, population=0)
        dem1.add_population_parameters_change(time=4000, initial_size=10000, population=0)

        dem0.sort_events()
        dem1.sort_events()


        with open(output_ThreeEpB_1000, "w+") as f0:
            ts0 = msprime.sim_ancestry(samples={"ThreeEpB_1000": sample_size},
                demography=dem0, sequence_length=5000000, recombination_rate=1e-8)
            mts0 = msprime.sim_mutations(ts0, rate=1.5E-8)
            mts0.write_vcf(f0)

        with open(output_ThreeEpB_2000, "w+") as f1:
            ts1 = msprime.sim_ancestry(samples={"ThreeEpB_2000": sample_size},
                demography=dem1, sequence_length=5000000, recombination_rate=1e-8)
            mts1 = msprime.sim_mutations(ts1, rate=1.5E-8)
            mts1.write_vcf(f1)



        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    msPrimeSimulate().main()
