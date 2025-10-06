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
import tskit

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
    
    def ensure_parent_dir_exists(self, filepath):
        parent_dir = os.path.dirname(filepath)
        if parent_dir and not os.path.exists(parent_dir):
            os.makedirs(parent_dir)

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
        output_ThreeEpB = '{0}{1}ThreeEpochGrowthContraction_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_ThreeEpB = '{0}{1}ThreeEpochGrowthContraction_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_ThreeEpB = \
           '{0}{1}ThreeEpochGrowthContraction_{2}_branch_length_dist_{3}.csv'.format(
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
        dem4 = msprime.Demography()
        # Three epoch ancient growth, then contraction, population 4
        dem4.add_population(name="ThreeEpGC", 
                            description="Three epoch growth + contraction", initial_size=1000)

        # Demographic events
        dem4.add_population_parameters_change(time=200, initial_size=50000, population=0)
        dem4.add_population_parameters_change(time=2000, initial_size=10000, population=0)

        dem4.sort_events()

        ts4 = msprime.sim_ancestry(samples={"ThreeEpGC": sample_size},
            demography=dem4, sequence_length=5000000, recombination_rate=1e-8,
            random_seed=replicate)
        tree_4 = ts4.first()
        logger.info('First tree in ThreeEpB: \n{0}'.format(tree_4))
        self.ensure_parent_dir_exists(coalescent_ThreeEpB)
        with open(coalescent_ThreeEpB, "w+") as g4:
            logger.info('Writing coalescent times for ThreeEpB.')
            g4.write('Node, generations\n')
            for u in tree_4.nodes():
                # Retain coalescent events
                if not tree_4.is_leaf(u):
                    g4.write(f"Node {u}, {tree_4.time(u)}\n")
        self.ensure_parent_dir_exists(branch_length_ThreeEpB)
        with open(branch_length_ThreeEpB, "w+") as h4:
            logger.info('Writing branch lengths for ThreeEpB.')
            h4.write('node_generations, branch_length\n')
            for u in tree_4.nodes():
                p = tree_4.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_4.time(p) - tree_4.time(u)
                    h4.write(f"{tree_4.time(u)}, {branch_length}\n")
                    
        with open(output_ThreeEpB, "w+") as f4:
            logger.info('Simulating three-epoch bottleneck.')
            mts4 = msprime.sim_mutations(ts4, rate=1.5E-8)
            mts4.write_vcf(f4)

        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    msPrimeSimulate().main()
