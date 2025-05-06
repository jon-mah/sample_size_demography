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
        output_contraction = '{0}{1}T500/contraction_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_expansion = '{0}{1}T500/expansion_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_bottleneck = '{0}{1}T500/bottleneck_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_contraction_short = '{0}{1}T50/contraction_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_expansion_short = '{0}{1}T50/expansion_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_bottleneck_short = '{0}{1}T50/bottleneck_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_contraction_no_r = '{0}{1}no_r/contraction_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_expansion_no_r = '{0}{1}no_r/expansion_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_bottleneck_no_r = '{0}{1}no_r/bottleneck_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_contraction_small_nu = '{0}{1}small_nu/contraction_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_expansion_small_nu = '{0}{1}small_nu/expansion_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_bottleneck_small_nu = '{0}{1}small_nu/bottleneck_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_contraction_large_nu = '{0}{1}large_nu/contraction_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_expansion_large_nu = '{0}{1}large_nu/expansion_{2}.vcf'.format(args['outprefix'], underscore, replicate)
        output_bottleneck_large_nu = '{0}{1}large_nu/bottleneck_{2}.vcf'.format(args['outprefix'], underscore, replicate)
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
        # dem3 = msprime.Demography() # Two epoch contraction short
        # dem4 = msprime.Demography() # Two epoch expansion short
        # dem5 = msprime.Demography() # Three epoch bottleneck short
        # dem6 = msprime.Demography() # Two epoch contraction small nu
        # dem7 = msprime.Demography() # Two epoch expansion small nu
        # dem8 = msprime.Demography() # Three epoch bottleneck small nu
        # dem9 = msprime.Demography() # Two epoch expansion large nu
        # dem10 = msprime.Demography() # Two epoch expanion large nu
        # dem11 = msprime.Demography() # Three epoch bottleneck large nu

        # Two epoch contraction, population 0
        dem0.add_population(name="TwoEpC", description="Two epoch contraction", initial_size=1000)
        # Two epoch expansion, population 1
        dem1.add_population(name="TwoEpE", description="Two epoch expansion", initial_size=10000)
        # Three epoch bottleneck, population 2
        dem2.add_population(name="ThreeEpB", description="Three epoch bottleneck", initial_size=10000)
        # # Two epoch contraction short, population 3
        # dem3.add_population(name="TwoEpC_short", description="Two epoch contraction short", initial_size=1000)
        # # Two epoch expansion short, population 4
        # dem4.add_population(name="TwoEpE_short", description="Two epoch expansion short", initial_size=10000)
        # # Three epoch bottleneck short, population 5
        # dem5.add_population(name="ThreeEpB_short", description="Three epoch bottleneck short", initial_size=10000)
        # # Two epoch contraction small nu, population 6
        # dem6.add_population(name="TwoEpC_small_nu", description="Two epoch contraction small nu", initial_size=5000)
        # # Two epoch expansion small nu, population 7
        # dem7.add_population(name="TwoEpE_small_nu", description="Two epoch expansion small nu", initial_size=10000)
        # # Three epoch bottleneck small nu, population 8
        # dem8.add_population(name="ThreeEpB_small_nu", description="Three epoch bottleneck small nu", initial_size=7500)
        # # Two epoch contraction large nu, population 9
        # dem9.add_population(name="TwoEpC_large_nu", description="Two epoch contraction large nu", initial_size=100)
        # # Two epoch expansion large nu, population 10
        # dem10.add_population(name="TwoEpE_large_nu", description="Two epoch expansion large nu", initial_size=10000)
        # # Three epoch bottleneck large nu, population 11
        # dem11.add_population(name="ThreeEpB_large_nu", description="Three epoch bottleneck large nu", initial_size=10000)

        # Demographic events, Contraction, E[s] = 195
        dem0.add_population_parameters_change(time=1500, initial_size=10000, population=0) # Contraction

        # Demographic events, Expansion, E[s] = 195
        dem1.add_population_parameters_change(time=2100, initial_size=1000, population=0) # Expansion

        # Demographic events, Bottleneck, E[s] = 255
        dem2.add_population_parameters_change(time=3100, initial_size=5000, population=0) # Bottleneck
        dem2.add_population_parameters_change(time=2100, initial_size=1000, population=0) # Bottleneck

        # # Demographic events, T_k = 50 generations
        # dem3.add_population_parameters_change(time=200, initial_size=10000, population=0) # Contraction
        # dem3.add_population_parameters_change(time=150, initial_size=10000, population=0) # Contraction
        # dem3.add_population_parameters_change(time=100, initial_size=1000, population=0) # Contraction
        # dem3.add_population_parameters_change(time=50, initial_size=1000, population=0) # Contraction

        # dem4.add_population_parameters_change(time=200, initial_size=1000, population=0) # Expansion
        # dem4.add_population_parameters_change(time=150, initial_size=1000, population=0) # Expansion
        # dem4.add_population_parameters_change(time=100, initial_size=10000, population=0) # Expansion
        # dem4.add_population_parameters_change(time=50, initial_size=10000, population=0) # Expansion

        # dem5.add_population_parameters_change(time=200, initial_size=5000, population=0) # Bottleneck
        # dem5.add_population_parameters_change(time=150, initial_size=5000, population=0) # Bottleneck
        # dem5.add_population_parameters_change(time=100, initial_size=1000, population=0) # Bottleneck
        # dem5.add_population_parameters_change(time=50, initial_size=10000, population=0) # Bottleneck

        # # Demographic events, T_k = 500 generations, small nu
        # dem6.add_population_parameters_change(time=2000, initial_size=10000, population=0) # Contraction
        # dem6.add_population_parameters_change(time=1500, initial_size=10000, population=0) # Contraction
        # dem6.add_population_parameters_change(time=1000, initial_size=5000, population=0) # Contraction
        # dem6.add_population_parameters_change(time=500, initial_size=5000, population=0) # Contraction

        # dem7.add_population_parameters_change(time=2000, initial_size=5000, population=0) # Expansion
        # dem7.add_population_parameters_change(time=1500, initial_size=5000, population=0) # Expansion
        # dem7.add_population_parameters_change(time=1000, initial_size=10000, population=0) # Expansion
        # dem7.add_population_parameters_change(time=500, initial_size=10000, population=0) # Expansion

        # dem8.add_population_parameters_change(time=2000, initial_size=5000, population=0) # Bottleneck
        # dem8.add_population_parameters_change(time=1500, initial_size=5000, population=0) # Bottleneck
        # dem8.add_population_parameters_change(time=1000, initial_size=2500, population=0) # Bottleneck
        # dem8.add_population_parameters_change(time=500, initial_size=7500, population=0) # Bottleneck

        # # Demographic events, T_k = 500 generations, large nu
        # dem9.add_population_parameters_change(time=2000, initial_size=10000, population=0) # Contraction
        # dem9.add_population_parameters_change(time=1500, initial_size=10000, population=0) # Contraction
        # dem9.add_population_parameters_change(time=1000, initial_size=100, population=0) # Contraction
        # dem9.add_population_parameters_change(time=500, initial_size=100, population=0) # Contraction

        # dem10.add_population_parameters_change(time=2000, initial_size=100, population=0) # Expansion
        # dem10.add_population_parameters_change(time=1500, initial_size=100, population=0) # Expansion
        # dem10.add_population_parameters_change(time=1000, initial_size=10000, population=0) # Expansion
        # dem10.add_population_parameters_change(time=500, initial_size=10000, population=0) # Expansion

        # dem11.add_population_parameters_change(time=2000, initial_size=5000, population=0) # Bottleneck
        # dem11.add_population_parameters_change(time=1500, initial_size=5000, population=0) # Bottleneck
        # dem11.add_population_parameters_change(time=1000, initial_size=100, population=0) # Bottleneck
        # dem11.add_population_parameters_change(time=500, initial_size=10000, population=0) # Bottleneck

        dem0.sort_events()
        dem1.sort_events()
        dem2.sort_events()
        # dem3.sort_events()
        # dem4.sort_events()
        # dem5.sort_events()
        # dem6.sort_events()
        # dem7.sort_events()
        # dem8.sort_events()
        # dem9.sort_events()
        # dem10.sort_events()
        # dem11.sort_events()

        with open(output_contraction, "w+") as f0:
            ts0 = msprime.sim_ancestry(samples={"TwoEpC": 5},
                demography=dem0, sequence_length=1000000, recombination_rate=1e-8)
            mts0 = msprime.sim_mutations(ts0, rate=1.5E-8)
            mts0.write_vcf(f0)

        with open(output_expansion, "w+") as f1:
            ts1 = msprime.sim_ancestry(samples={"TwoEpE": 5},
                demography=dem1, sequence_length=1000000, recombination_rate=1e-8)
            mts1 = msprime.sim_mutations(ts1, rate=1.5E-8)
            mts1.write_vcf(f1)

        with open(output_bottleneck, "w+") as f2:
            ts2 = msprime.sim_ancestry(samples={"ThreeEpB": 5},
                demography=dem2, sequence_length=1000000, recombination_rate=1e-8)
            mts2 = msprime.sim_mutations(ts2, rate=1.5E-8)
            mts2.write_vcf(f2)

        # with open(output_contraction_short, "w+") as f3:
        #     ts3 = msprime.sim_ancestry(samples={"TwoEpC_short": 1000},
        #         demography=dem3, sequence_length=1000000, recombination_rate=1e-8)
        #     mts3 = msprime.sim_mutations(ts3, rate=1.5E-8)
        #     mts3.write_vcf(f3)

        # with open(output_expansion_short, "w+") as f4:
        #     ts4 = msprime.sim_ancestry(samples={"TwoEpE_short": 10000},
        #         demography=dem4, sequence_length=1000000, recombination_rate=1e-8)
        #     mts4 = msprime.sim_mutations(ts4, rate=1.5E-8)
        #     mts4.write_vcf(f4)

        # with open(output_bottleneck_short, "w+") as f5:
        #     ts5 = msprime.sim_ancestry(samples={"ThreeEpB_short": 10000},
        #         demography=dem5, sequence_length=1000000, recombination_rate=1e-8)
        #     mts5 = msprime.sim_mutations(ts5, rate=1.5E-8)
        #     mts5.write_vcf(f5)

        # with open(output_contraction_no_r, "w+") as f6:
        #     ts0_no_r = msprime.sim_ancestry(samples={"TwoEpC": 1000},
        #         demography=dem0, sequence_length=1000000, recombination_rate=0.0)
        #     mts0_no_r = msprime.sim_mutations(ts0_no_r, rate=1.5E-8)
        #     mts0_no_r.write_vcf(f6)

        # with open(output_expansion_no_r, "w+") as f7:
        #     ts1_no_r = msprime.sim_ancestry(samples={"TwoEpE": 10000},
        #         demography=dem1, sequence_length=1000000, recombination_rate=0.0)
        #     mts1_no_r = msprime.sim_mutations(ts1_no_r, rate=1.5E-8)
        #     mts1_no_r.write_vcf(f7)

        # with open(output_bottleneck_no_r, "w+") as f8:
        #     ts2_no_r = msprime.sim_ancestry(samples={"ThreeEpB": 10000},
        #         demography=dem2, sequence_length=1000000, recombination_rate=0.0)
        #     mts2_no_r = msprime.sim_mutations(ts2_no_r, rate=1.5E-8)
        #     mts2_no_r.write_vcf(f8)

        # with open(output_contraction_small_nu, "w+") as f9:
        #     ts6 = msprime.sim_ancestry(samples={"TwoEpC_small_nu": 5000},
        #         demography=dem6, sequence_length=1000000, recombination_rate=1e-8)
        #     mts6 = msprime.sim_mutations(ts6, rate=1.5E-8)
        #     mts6.write_vcf(f9)

        # with open(output_expansion_small_nu, "w+") as f10:
        #     ts7 = msprime.sim_ancestry(samples={"TwoEpE_small_nu": 10000},
        #         demography=dem7, sequence_length=1000000, recombination_rate=1e-8)
        #     mts7 = msprime.sim_mutations(ts7, rate=1.5E-8)
        #     mts7.write_vcf(f10)

        # with open(output_bottleneck_small_nu, "w+") as f11:
        #     ts8 = msprime.sim_ancestry(samples={"ThreeEpB_small_nu": 7500},
        #         demography=dem8, sequence_length=1000000, recombination_rate=1e-8)
        #     mts8 = msprime.sim_mutations(ts8, rate=1.5E-8)
        #     mts8.write_vcf(f11)

        # with open(output_contraction_large_nu, "w+") as f12:
        #     ts9 = msprime.sim_ancestry(samples={"TwoEpC_large_nu": 100},
        #         demography=dem9, sequence_length=1000000, recombination_rate=1e-8)
        #     mts9 = msprime.sim_mutations(ts9, rate=1.5E-8)
        #     mts9.write_vcf(f12)

        # with open(output_expansion_large_nu, "w+") as f13:
        #     ts10 = msprime.sim_ancestry(samples={"TwoEpE_large_nu": 10000},
        #         demography=dem10, sequence_length=1000000, recombination_rate=1e-8)
        #     mts10 = msprime.sim_mutations(ts10, rate=1.5E-8)
        #     mts10.write_vcf(f13)

        # with open(output_bottleneck_large_nu, "w+") as f14:
        #     ts11 = msprime.sim_ancestry(samples={"ThreeEpB_large_nu": 10000},
        #         demography=dem11, sequence_length=1000000, recombination_rate=1e-8)
        #     mts11 = msprime.sim_mutations(ts11, rate=1.5E-8)
        #     mts11.write_vcf(f14)

        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    msPrimeSimulate().main()
