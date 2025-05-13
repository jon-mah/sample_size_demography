""" Uses MSPrime to simulate three demographic scenarios.

JCM 20250501
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
            'replicate', type=str,
            help='An integer indexing the replicate.')
        parser.add_argument(
            'sample_size', type=int,
            help='Sample size for number of lineages.')
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
        replicate = args['replicate']
        sample_size = args['sample_size']
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
        logfile = '{0}{1}msprime_simulations/log_{2}.log'.format(args['outprefix'], underscore, replicate)
        output_contraction_k5 = '{0}{1}msprime_simulations/k{2}_contraction_{3}.vcf'.format(args['outprefix'], underscore, sample_size, replicate)
        output_expansion_k5 = '{0}{1}msprime_simulations/k{2}_expansion_{3}.vcf'.format(args['outprefix'], underscore, sample_size, replicate)
        output_bottleneck_k5 = '{0}{1}msprime_simulations/k{2}_bottleneck_{3}.vcf'.format(args['outprefix'], underscore, sample_size, replicate)
        output_snm = '{0}{1}msprime_simulations/k{2}_snm_{3}.vcf'.format(args['outprefix'], underscore, sample_size, replicate)
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
        dem0 = msprime.Demography() # Two epoch contraction
        dem1 = msprime.Demography() # Two epoch expansion
        dem2 = msprime.Demography() # Three epoch bottleneck
        dem3 = msprime.Demography() # Two epoch contraction short


        # Two epoch contraction, population 0
        dem0.add_population(name="TwoEpC", description="Two epoch contraction", initial_size=1000)
        # Two epoch expansion, population 1
        dem1.add_population(name="TwoEpE", description="Two epoch expansion", initial_size=10000)
        # Three epoch bottleneck, population 2
        dem2.add_population(name="ThreeEpB", description="Three epoch bottleneck", initial_size=10000)
        dem3.add_population(name="Snm", description="Standard neutral model", initial_size=10000)

        # Demographic events, Contraction, E[s] = 195
        dem0.add_population_parameters_change(time=1500, initial_size=10000, population=0) # Contraction

        # Demographic events, Expansion, E[s] = 195
        dem1.add_population_parameters_change(time=2500, initial_size=1000, population=0) # Expansion

        # Demographic events, Bottleneck, E[s] = 255
        dem2.add_population_parameters_change(time=3100, initial_size=5000, population=0) # Bottleneck
        dem2.add_population_parameters_change(time=2100, initial_size=1000, population=0) # Bottleneck

        dem0.sort_events()
        dem1.sort_events()
        dem2.sort_events()

        with open(output_contraction_k5, "w+") as f0:
            ts0 = msprime.sim_ancestry(samples={"TwoEpC": sample_size}, ploidy=2,
                demography=dem0, sequence_length=1000000, recombination_rate=1e-8)
            mts0 = msprime.sim_mutations(ts0, rate=1.5E-8)
            mts0.write_vcf(f0)

        with open(output_expansion_k5, "w+") as f1:
            ts1 = msprime.sim_ancestry(samples={"TwoEpE": sample_size}, ploidy=2,
                demography=dem1, sequence_length=1000000, recombination_rate=1e-8)
            mts1 = msprime.sim_mutations(ts1, rate=1.5E-8)
            mts1.write_vcf(f1)

        with open(output_bottleneck_k5, "w+") as f2:
            ts2 = msprime.sim_ancestry(samples={"ThreeEpB": sample_size}, ploidy=2,
                demography=dem2, sequence_length=1000000, recombination_rate=1e-8)
            mts2 = msprime.sim_mutations(ts2, rate=1.5E-8)
            mts2.write_vcf(f2)

        with open(output_snm, "w+") as f3:
            ts3 = msprime.sim_ancestry(samples={"Snm": sample_size}, ploidy=2,
                demography=dem3, sequence_length=1000000, recombination_rate=1e-8)
            mts3 = msprime.sim_mutations(ts3, rate=1.5E-8)
            mts3.write_vcf(f3)

        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    msPrimeSimulate().main()
