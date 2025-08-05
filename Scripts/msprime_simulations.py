""" Uses MSPrime to simulate four demographic scenarios.

JCM 20240207
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
        output_TwoEpC = '{0}{1}TwoEpochContraction_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_TwoEpC = '{0}{1}TwoEpochContraction_{2}_{3}/coal_dist.txt'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_TwoEpE = '{0}{1}TwoEpochExpansion_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_TwoEpE = '{0}{1}TwoEpochExpansion_{2}_{3}/coal_dist.txt'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpC = '{0}{1}ThreeEpochContraction_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_ThreeEpC = '{0}{1}ThreeEpochContraction_{2}_{3}/coal_dist.txt'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpE = '{0}{1}ThreeEpochExpansion_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_ThreeEpE = '{0}{1}ThreeEpochExpansion_{2}_{3}/coal_dist.txt'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB = '{0}{1}ThreeEpochBottleneck_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_ThreeEpB = '{0}{1}ThreeEpochBottleneck_{2}_{3}/coal_dist.txt'.format(
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
        dem2 = msprime.Demography()
        dem3 = msprime.Demography()
        dem4 = msprime.Demography()
        # Two epoch contraction, population 0
        dem0.add_population(name="TwoEpC", description="Two epoch contraction", initial_size=5000)
        # Two epoch expansion, population 1
        dem1.add_population(name="TwoEpE", description="Two epoch expansion", initial_size=20000)
        # Three epoch double contraction, population 2
        dem2.add_population(name="ThreeEpC", description="Three epoch contraction", initial_size=2500)
        # Three epoch double expansion, population 3
        dem3.add_population(name="ThreeEpE", description="Three epoch expansion", initial_size=40000)
        # Three epoch ancient bottleneck, population 4
        dem4.add_population(name="ThreeEpB", description="Three epcoh bottleneck", initial_size=50000)

        # Demographic events
        dem0.add_population_parameters_change(time=2000, initial_size=10000, population=0)
        dem1.add_population_parameters_change(time=200, initial_size=10000, population=0)
        dem2.add_population_parameters_change(time=200, initial_size=5000, population=0)
        dem2.add_population_parameters_change(time=2000, initial_size=10000, population=0)
        dem3.add_population_parameters_change(time=200, initial_size=20000, population=0)
        dem3.add_population_parameters_change(time=2000, initial_size=10000, population=0)
        dem4.add_population_parameters_change(time=200, initial_size=1000, population=0)
        dem4.add_population_parameters_change(time=2000, initial_size=10000, population=0)

        dem0.sort_events()
        dem1.sort_events()
        dem2.sort_events()
        dem3.sort_events()
        dem4.sort_events()

        ts0 = msprime.sim_ancestry(samples={"TwoEpC" : sample_size},
            demography=dem0, sequence_length=5000000, recombination_rate=1e-8)
        tree_0 = ts0.first()
        logger.info('First tree in TwoEpC: {0}'.format(tree_0))
        with open(coalescent_TwoEpC, "w+") as g0:
            logger.info('Writing coalescent times for TwoEpC.')
            for u in tree_0.nodes():
                g0.write(f"Node {u}: time {tree_0.time(u)}\n")

        ts1 = msprime.sim_ancestry(samples={"TwoEpE" : sample_size},
            demography=dem1, sequence_length=5000000, recombination_rate=1e-8)
        tree_1 = ts1.first()
        logger.info('First tree in TwoEpE: {0}'.format(tree_1))
        with open(coalescent_TwoEpE, "w+") as g1:
            logger.info('Writing coalescent times for TwoEpE.')
            for u in tree_1.nodes():
                g1.write(f"Node {u}: time {tree_1.time(u)}\n")

        ts2 = msprime.sim_ancestry(samples={"ThreeEpC" : sample_size},
            demography=dem2, sequence_length=5000000, recombination_rate=1e-8)
        tree_2 = ts2.first()
        logger.info('First tree in ThreeEpC: {0}'.format(tree_2))
        with open(coalescent_ThreeEpC, "w+") as g2:
            logger.info('Writing coalescent times for ThreeEpC.')
            for u in tree_2.nodes():
                g2.write(f"Node {u}: time {tree_2.time(u)}\n")

        ts3 = msprime.sim_ancestry(samples={"ThreeEpE": sample_size},
            demography=dem3, sequence_length=5000000, recombination_rate=1e-8)
        tree_3 = ts3.first()
        logger.info('First tree in ThreeEpE: {0}'.format(tree_3))
        with open(coalescent_ThreeEpE, "w+") as g3:
            logger.info('Writing coalescent times for ThreeEpE.')
            for u in tree_3.nodes():
                g3.write(f"Node {u}: time {tree_3.time(u)}\n")

        ts4 = msprime.sim_ancestry(samples={"ThreeEpB": sample_size},
            demography=dem4, sequence_length=5000000, recombination_rate=1e-8)
        tree_4 = ts4.first()
        logger.info('First tree in ThreeEpB: {0}'.format(tree_4))
        with open(coalescent_ThreeEpB, "w+") as g4:
            logger.info('Writing coalescent times for ThreeEpB.')
            for u in tree_4.nodes():
                g4.write(f"Node {u}: time {tree_4.time(u)}\n")

        with open(output_TwoEpC, "w+") as f0:
            logger.info('Simulating two-epoch contraction.')
            mts0 = msprime.sim_mutations(ts0, rate=1.5E-8)
            mts0.write_vcf(f0)

        with open(output_TwoEpE, "w+") as f1:
            logger.info('Simulating two-epoch expansion.')
            mts1 = msprime.sim_mutations(ts1, rate=1.5E-8)
            mts1.write_vcf(f1)

        with open(output_ThreeEpC, "w+") as f2:
            logger.info('Simulating three-epoch contraction.')
            mts2 = msprime.sim_mutations(ts2, rate=1.5E-8)
            mts2.write_vcf(f2)

        with open(output_ThreeEpE, "w+") as f3:
            logger.info('Simulating three-epoch expansion.')
            mts3 = msprime.sim_mutations(ts3, rate=1.5E-8)
            mts3.write_vcf(f3)

        with open(output_ThreeEpB, "w+") as f4:
            logger.info('Simulating three-epoch bottleneck.')
            mts4 = msprime.sim_mutations(ts4, rate=1.5E-8)
            mts4.write_vcf(f4)

        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    msPrimeSimulate().main()
