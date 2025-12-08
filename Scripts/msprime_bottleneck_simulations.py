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
        output_ThreeEpB_1000_500 = '{0}{1}ThreeEpochBottleneck_1000_500_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_1000_500 = '{0}{1}ThreeEpochBottleneck_1000_500_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_1000_500 = \
           '{0}{1}ThreeEpochBottleneck_1000_500_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_1000_1000 = '{0}{1}ThreeEpochBottleneck_1000_1000_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_1000_1000 = '{0}{1}ThreeEpochBottleneck_1000_1000_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_1000_1000 = \
           '{0}{1}ThreeEpochBottleneck_1000_1000_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_1000_1500 = '{0}{1}ThreeEpochBottleneck_1000_1500_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_1000_1500 = '{0}{1}ThreeEpochBottleneck_1000_1500_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_1000_1500 = \
           '{0}{1}ThreeEpochBottleneck_1000_1500_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_1000_2000 = '{0}{1}ThreeEpochBottleneck_1000_2000_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_1000_2000 = '{0}{1}ThreeEpochBottleneck_1000_2000_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_1000_2000 = \
           '{0}{1}ThreeEpochBottleneck_1000_2000_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_500_2000 = '{0}{1}ThreeEpochBottleneck_500_2000_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_500_2000 = '{0}{1}ThreeEpochBottleneck_500_2000_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_500_2000 = \
           '{0}{1}ThreeEpochBottleneck_500_2000_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_1500_2000 = '{0}{1}ThreeEpochBottleneck_1500_2000_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_1500_2000 = '{0}{1}ThreeEpochBottleneck_1500_2000_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_1500_2000 = \
           '{0}{1}ThreeEpochBottleneck_1500_2000_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_2000_2000 = '{0}{1}ThreeEpochBottleneck_2000_2000_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_2000_2000 = '{0}{1}ThreeEpochBottleneck_2000_2000_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_2000_2000 = \
           '{0}{1}ThreeEpochBottleneck_2000_2000_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)

        output_ThreeEpB_100_50 = '{0}{1}ThreeEpochBottleneck_100_50_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_100_50 = '{0}{1}ThreeEpochBottleneck_100_50_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_100_50 = \
           '{0}{1}ThreeEpochBottleneck_100_50_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_100_100 = '{0}{1}ThreeEpochBottleneck_100_100_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_100_100 = '{0}{1}ThreeEpochBottleneck_100_100_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_100_100 = \
           '{0}{1}ThreeEpochBottleneck_100_100_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_100_150 = '{0}{1}ThreeEpochBottleneck_100_150_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_100_150 = '{0}{1}ThreeEpochBottleneck_100_150_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_100_150 = \
           '{0}{1}ThreeEpochBottleneck_100_150_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_100_200 = '{0}{1}ThreeEpochBottleneck_100_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_100_200 = '{0}{1}ThreeEpochBottleneck_100_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_100_200 = \
           '{0}{1}ThreeEpochBottleneck_100_200_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_50_200 = '{0}{1}ThreeEpochBottleneck_50_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_50_200 = '{0}{1}ThreeEpochBottleneck_50_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_50_200 = \
           '{0}{1}ThreeEpochBottleneck_50_200_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_150_200 = '{0}{1}ThreeEpochBottleneck_150_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_150_200 = '{0}{1}ThreeEpochBottleneck_150_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_150_200 = \
           '{0}{1}ThreeEpochBottleneck_150_200_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_200_200 = '{0}{1}ThreeEpochBottleneck_200_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_200_200 = '{0}{1}ThreeEpochBottleneck_200_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_200_200 = \
           '{0}{1}ThreeEpochBottleneck_200_200_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_400_200 = '{0}{1}ThreeEpochBottleneck_400_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_400_200 = '{0}{1}ThreeEpochBottleneck_400_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_400_200 = \
           '{0}{1}ThreeEpochBottleneck_400_200_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_600_200 = '{0}{1}ThreeEpochBottleneck_600_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_600_200 = '{0}{1}ThreeEpochBottleneck_600_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_600_200 = \
           '{0}{1}ThreeEpochBottleneck_600_200_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_800_200 = '{0}{1}ThreeEpochBottleneck_800_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_800_200 = '{0}{1}ThreeEpochBottleneck_800_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_800_200 = \
           '{0}{1}ThreeEpochBottleneck_800_200_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_1000_200 = '{0}{1}ThreeEpochBottleneck_1000_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_1000_200 = '{0}{1}ThreeEpochBottleneck_1000_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_1000_200 = \
           '{0}{1}ThreeEpochBottleneck_1000_200_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_1200_200 = '{0}{1}ThreeEpochBottleneck_1200_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_1200_200 = '{0}{1}ThreeEpochBottleneck_1200_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_1200_200 = \
           '{0}{1}ThreeEpochBottleneck_1200_200_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_1400_200 = '{0}{1}ThreeEpochBottleneck_1400_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_1400_200 = '{0}{1}ThreeEpochBottleneck_1400_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_1400_200 = \
           '{0}{1}ThreeEpochBottleneck_1400_200_{2}_branch_length_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        output_ThreeEpB_1600_200 = '{0}{1}ThreeEpochBottleneck_1600_200_{2}_{3}.vcf'.format(
            args['outprefix'], underscore, sample_size, replicate)
        coalescent_1600_200 = '{0}{1}ThreeEpochBottleneck_1600_200_{2}_coal_dist_{3}.csv'.format(
            args['outprefix'], underscore, sample_size, replicate)
        branch_length_1600_200 = \
           '{0}{1}ThreeEpochBottleneck_1600_200_{2}_branch_length_dist_{3}.csv'.format(
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
        dem0 = msprime.Demography() # 1000_500
        dem1 = msprime.Demography() # 1000_1000
        dem2 = msprime.Demography() # 1000_1500
        dem3 = msprime.Demography() # 1000_2000
        dem4 = msprime.Demography() # 500_2000
        dem5 = msprime.Demography() # 1500_2000
        dem6 = msprime.Demography() # 2000_2000

        dem7 = msprime.Demography() # 100_50
        dem8 = msprime.Demography() # 100_100
        dem9 = msprime.Demography() # 100_150
        dem10 = msprime.Demography() # 100_200
        dem11 = msprime.Demography() # 50_200
        dem12 = msprime.Demography() # 150_200
        dem13 = msprime.Demography() # 200_200
        dem14 = msprime.Demography() # 400_200
        dem15 = msprime.Demography() # 6000_200
        dem16 = msprime.Demography() # 800_200
        dem17 = msprime.Demography() # 1000_200
        dem18 = msprime.Demography() # 1200_200
        dem19 = msprime.Demography() # 1400_200
        dem20 = msprime.Demography() # 1600_200


        # Three epoch ancient bottleneck, population
        dem0.add_population(name="ThreeEpB_1000_500", 
            description="Three epoch bottleneck, 1000, 500", initial_size=50000)
        dem1.add_population(name="ThreeEpB_1000_1000",
            description="Three epoch bottleneck, 1000, 1000", initial_size=50000)
        dem2.add_population(name="ThreeEpB_1000_1500",
            description="Three epoch bottleneck, 1000, 1500", initial_size=50000)
        dem3.add_population(name="ThreeEpB_1000_2000",
            description="Three epoch bottleneck, 1000, 2000", initial_size=50000)
        dem4.add_population(name="ThreeEpB_500_2000",
            description="Three epoch bottleneck, 500, 2000", initial_size=50000)
        dem5.add_population(name="ThreeEpB_1500_2000",
            description="Three epoch bottleneck, 1500, 2000", initial_size=50000)
        dem6.add_population(name="ThreeEpB_2000_2000", 
            description="Three epoch bottleneck, 2000, 2000", initial_size=50000)

        dem7.add_population(name="ThreeEpB_100_50", 
            description="Three epoch bottleneck, 100, 50", initial_size=50000)
        dem8.add_population(name="ThreeEpB_100_100",
            description="Three epoch bottleneck, 100, 100", initial_size=50000)
        dem9.add_population(name="ThreeEpB_100_150",
            description="Three epoch bottleneck, 100, 150", initial_size=50000)
        dem10.add_population(name="ThreeEpB_100_200",
            description="Three epoch bottleneck, 100, 200", initial_size=50000)
        dem11.add_population(name="ThreeEpB_50_200",
            description="Three epoch bottleneck, 50, 200", initial_size=50000)
        dem12.add_population(name="ThreeEpB_150_200",
            description="Three epoch bottleneck, 150, 200", initial_size=50000)
        dem13.add_population(name="ThreeEpB_200_200", 
            description="Three epoch bottleneck, 200, 200", initial_size=50000)
        dem14.add_population(name="ThreeEpB_400_200", 
            description="Three epoch bottleneck, 400, 200", initial_size=50000)
        dem15.add_population(name="ThreeEpB_600_200",
            description="Three epoch bottleneck, 600, 200", initial_size=50000)
        dem16.add_population(name="ThreeEpB_800_200",
            description="Three epoch bottleneck, 800, 200", initial_size=50000)
        dem17.add_population(name="ThreeEpB_1000_200",
            description="Three epoch bottleneck, 1000, 200", initial_size=50000)
        dem18.add_population(name="ThreeEpB_1200_200",
            description="Three epoch bottleneck, 1200, 200", initial_size=50000)
        dem19.add_population(name="ThreeEpB_1400_200",
            description="Three epoch bottleneck, 1400, 200", initial_size=50000)
        dem20.add_population(name="ThreeEpB_1600_200",
            description="Three epoch bottleneck, 1600, 200", initial_size=50000)


        # Demographic events
        dem0.add_population_parameters_change(time=1000, initial_size=1000, population=0)
        dem0.add_population_parameters_change(time=1500, initial_size=10000, population=0)

        dem1.add_population_parameters_change(time=1000, initial_size=1000, population=0)
        dem1.add_population_parameters_change(time=2000, initial_size=10000, population=0)

        dem2.add_population_parameters_change(time=1000, initial_size=1000, population=0)
        dem2.add_population_parameters_change(time=2500, initial_size=10000, population=0)

        dem3.add_population_parameters_change(time=1000, initial_size=1000, population=0)
        dem3.add_population_parameters_change(time=3000, initial_size=10000, population=0)

        dem4.add_population_parameters_change(time=500, initial_size=1000, population=0)
        dem4.add_population_parameters_change(time=2500, initial_size=10000, population=0)

        dem5.add_population_parameters_change(time=1000, initial_size=1000, population=0)
        dem5.add_population_parameters_change(time=3500, initial_size=10000, population=0)

        dem6.add_population_parameters_change(time=2000, initial_size=1000, population=0)
        dem6.add_population_parameters_change(time=4000, initial_size=10000, population=0)

        # dem7.add_population_parameters_change(time=100, initial_size=1000, population=0)
        # dem7.add_population_parameters_change(time=150, initial_size=10000, population=0)

        # dem8.add_population_parameters_change(time=100, initial_size=1000, population=0)
        # dem8.add_population_parameters_change(time=200, initial_size=10000, population=0)

        # dem9.add_population_parameters_change(time=100, initial_size=1000, population=0)
        # dem9.add_population_parameters_change(time=250, initial_size=10000, population=0)

        # dem10.add_population_parameters_change(time=100, initial_size=1000, population=0)
        # dem10.add_population_parameters_change(time=300, initial_size=10000, population=0)

        # dem11.add_population_parameters_change(time=50, initial_size=1000, population=0)
        # dem11.add_population_parameters_change(time=250, initial_size=10000, population=0)

        # dem12.add_population_parameters_change(time=100, initial_size=1000, population=0)
        # dem12.add_population_parameters_change(time=350, initial_size=10000, population=0)

        # dem13.add_population_parameters_change(time=200, initial_size=1000, population=0)
        # dem13.add_population_parameters_change(time=400, initial_size=10000, population=0)

        dem14.add_population_parameters_change(time=200, initial_size=1000, population=0)
        dem14.add_population_parameters_change(time=600, initial_size=10000, population=0)

        dem15.add_population_parameters_change(time=200, initial_size=1000, population=0)
        dem15.add_population_parameters_change(time=800, initial_size=10000, population=0)

<<<<<<< Updated upstream
        # dem16.add_population_parameters_change(time=200, initial_size=1000, population=0)
        # dem16.add_population_parameters_change(time=1600, initial_size=10000, population=0)
=======
        dem16.add_population_parameters_change(time=200, initial_size=1000, population=0)
        dem16.add_population_parameters_change(time=1000, initial_size=10000, population=0)

        dem17.add_population_parameters_change(time=200, initial_size=1000, population=0)
        dem17.add_population_parameters_change(time=1200, initial_size=10000, population=0)

        dem18.add_population_parameters_change(time=200, initial_size=1000, population=0)
        dem18.add_population_parameters_change(time=1400, initial_size=10000, population=0)

        dem19.add_population_parameters_change(time=200, initial_size=1000, population=0)
        dem19.add_population_parameters_change(time=1600, initial_size=10000, population=0)

        dem20.add_population_parameters_change(time=200, initial_size=1000, population=0)
        dem20.add_population_parameters_change(time=1800, initial_size=10000, population=0)
>>>>>>> Stashed changes


        dem0.sort_events()
        dem1.sort_events()
        dem2.sort_events()
        dem3.sort_events()
        dem4.sort_events()
        dem5.sort_events()
        dem6.sort_events()
        # dem7.sort_events()
        # dem8.sort_events()
        # dem9.sort_events()
        # dem10.sort_events()
        # dem11.sort_events()
        # dem12.sort_events()
<<<<<<< Updated upstream
        # dem13.sort_events()
        # dem14.sort_events()
        # dem15.sort_events()
        # dem16.sort_events()
        print(dem0)
        print(dem1)
        print(dem2)
        print(dem3)
        print(dem4)
        print(dem5)
        print(dem6)
=======
        dem13.sort_events()
        dem14.sort_events()
        dem15.sort_events()
        dem16.sort_events()
        dem17.sort_events()
        dem18.sort_events()
        dem19.sort_events()
        dem20.sort_events()
        
        # print(dem0)
        # print(dem1)
        # print(dem2)
        # print(dem3)
        # print(dem4)
        # print(dem5)
        # print(dem6)
>>>>>>> Stashed changes
        # print(dem7)
        # print(dem8)
        # print(dem9)
        # print(dem10)
        # print(dem11)
        # print(dem12)
        # print(dem13)
        # print(dem14)
        # print(dem15)
        # print(dem16)
<<<<<<< Updated upstream
        with open(output_ThreeEpB_1000_500, "w+") as f0:
            ts0 = msprime.sim_ancestry(samples={"ThreeEpB_1000_500": sample_size},
                demography=dem0, sequence_length=5000000, recombination_rate=1e-8)
            mts0 = msprime.sim_mutations(ts0, rate=1.5E-8)
            mts0.write_vcf(f0)
            tree_0 = ts0.first()
            with open(coalescent_1000_500, "w+") as g0:
                g0.write('Node, generations\n')
                logger.info('Writing coalescent times for 1000_500.')
                for u in tree_0.nodes():
                    # Retain coalescent nodes
                    if not tree_0.is_leaf(u):  # skip sample nodes
                        g0.write(f"Node {u}, {tree_0.time(u)}\n")
        with open(branch_length_1000_500, "w+") as h0:
            logger.info('Writing branch lengths for 1000_500.')
            h0.write('node_generations, branch_length\n')
            for u in tree_0.nodes():
                p = tree_0.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_0.time(p) - tree_0.time(u)
                    h0.write(f"{tree_0.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_1000_1000, "w+") as f1:
            ts1 = msprime.sim_ancestry(samples={"ThreeEpB_1000_1000": sample_size},
                demography=dem1, sequence_length=5000000, recombination_rate=1e-8)
            mts1 = msprime.sim_mutations(ts1, rate=1.5E-8)
            mts1.write_vcf(f1)
            tree_1 = ts1.first()
            with open(coalescent_1000_1000, "w+") as g1:
                g1.write('Node, generations\n')
                logger.info('Writing coalescent times for 1000_1000.')
                for u in tree_1.nodes():
                    # Retain coalescent nodes
                    if not tree_1.is_leaf(u):  # skip sample nodes
                        g1.write(f"Node {u}, {tree_1.time(u)}\n")
        with open(branch_length_1000_1000, "w+") as h1:
            logger.info('Writing branch lengths for 1000_1000.')
            h1.write('node_generations, branch_length\n')
            for u in tree_1.nodes():
                p = tree_1.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_1.time(p) - tree_1.time(u)
                    h1.write(f"{tree_1.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_1000_1500, "w+") as f2:
            ts2 = msprime.sim_ancestry(samples={"ThreeEpB_1000_1500": sample_size},
                demography=dem2, sequence_length=5000000, recombination_rate=1e-8)
            mts2 = msprime.sim_mutations(ts2, rate=1.5E-8)
            mts2.write_vcf(f2)
            tree_2 = ts2.first()
            with open(coalescent_1000_1500, "w+") as g2:
                g2.write('Node, generations\n')
                logger.info('Writing coalescent times for 1000_1500.')
                for u in tree_2.nodes():
                    # Retain coalescent nodes
                    if not tree_2.is_leaf(u):  # skip sample nodes
                        g2.write(f"Node {u}, {tree_2.time(u)}\n")
        with open(branch_length_1000_1500, "w+") as h2:
            logger.info('Writing branch lengths for 1000_1500.')
            h2.write('node_generations, branch_length\n')
            for u in tree_2.nodes():
                p = tree_2.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_2.time(p) - tree_2.time(u)
                    h2.write(f"{tree_2.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_1000_2000, "w+") as f3:
            ts3 = msprime.sim_ancestry(samples={"ThreeEpB_1000_2000": sample_size},
                demography=dem3, sequence_length=5000000, recombination_rate=1e-8)
            mts3 = msprime.sim_mutations(ts3, rate=1.5E-8)
            mts3.write_vcf(f3)
            tree_3 = ts3.first()
            with open(coalescent_1000_2000, "w+") as g3:
                g3.write('Node, generations\n')
                logger.info('Writing coalescent times for 1000_2000.')
                for u in tree_3.nodes():
                    # Retain coalescent nodes
                    if not tree_3.is_leaf(u):  # skip sample nodes
                        g3.write(f"Node {u}, {tree_3.time(u)}\n")
        with open(branch_length_1000_2000, "w+") as h3:
            logger.info('Writing branch lengths for 1000_2000.')
            h3.write('node_generations, branch_length\n')
            for u in tree_3.nodes():
                p = tree_3.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_3.time(p) - tree_3.time(u)
                    h3.write(f"{tree_3.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_500_2000, "w+") as f4:
            ts4 = msprime.sim_ancestry(samples={"ThreeEpB_500_2000": sample_size},
                demography=dem4, sequence_length=5000000, recombination_rate=1e-8)
            mts4 = msprime.sim_mutations(ts4, rate=1.5E-8)
            mts4.write_vcf(f4)
            tree_4 = ts4.first()
            with open(coalescent_500_2000, "w+") as g4:
                g4.write('Node, generations\n')
                logger.info('Writing coalescent times for 1000_2000.')
                for u in tree_4.nodes():
                    # Retain coalescent nodes
                    if not tree_4.is_leaf(u):  # skip sample nodes
                        g4.write(f"Node {u}, {tree_4.time(u)}\n")
        with open(branch_length_500_2000, "w+") as h4:
            logger.info('Writing branch lengths for 500_2000.')
            h4.write('node_generations, branch_length\n')
            for u in tree_4.nodes():
                p = tree_4.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_4.time(p) - tree_4.time(u)
                    h4.write(f"{tree_4.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_1500_2000, "w+") as f5:
            ts5 = msprime.sim_ancestry(samples={"ThreeEpB_1500_2000": sample_size},
                demography=dem5, sequence_length=5000000, recombination_rate=1e-8)
            mts5 = msprime.sim_mutations(ts5, rate=1.5E-8)
            mts5.write_vcf(f5)
            tree_5 = ts5.first()
            with open(coalescent_1500_2000, "w+") as g5:
                g5.write('Node, generations\n')
                logger.info('Writing coalescent times for 1500_2000.')
                for u in tree_5.nodes():
                    # Retain coalescent nodes
                    if not tree_5.is_leaf(u):  # skip sample nodes
                        g5.write(f"Node {u}, {tree_5.time(u)}\n")
        with open(branch_length_1500_2000, "w+") as h5:
            logger.info('Writing branch lengths for 1500_2000.')
            h5.write('node_generations, branch_length\n')
            for u in tree_5.nodes():
                p = tree_5.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_5.time(p) - tree_5.time(u)
                    h5.write(f"{tree_5.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_2000_2000, "w+") as f6:
            ts6 = msprime.sim_ancestry(samples={"ThreeEpB_2000_2000": sample_size},
                demography=dem6, sequence_length=5000000, recombination_rate=1e-8)
            mts6 = msprime.sim_mutations(ts6, rate=1.5E-8)
            mts6.write_vcf(f6)
            tree_6 = ts6.first()
            with open(coalescent_2000_2000, "w+") as g6:
                g6.write('Node, generations\n')
                logger.info('Writing coalescent times for TwoEpC.')
                for u in tree_6.nodes():
                    # Retain coalescent nodes
                    if not tree_6.is_leaf(u):  # skip sample nodes
                        g6.write(f"Node {u}, {tree_6.time(u)}\n")
        with open(branch_length_2000_2000, "w+") as h6:
            logger.info('Writing branch lengths for 2000_2000.')
            h6.write('node_generations, branch_length\n')
            for u in tree_6.nodes():
                p = tree_6.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_6.time(p) - tree_6.time(u)
                    h6.write(f"{tree_6.time(u)}, {branch_length}\n")
=======
        # print(dem17)
        # print(dem18)
        # print(dem19)
        # print(dem20)
        # with open(output_ThreeEpB_1000_500, "w+") as f0:
        #     ts0 = msprime.sim_ancestry(samples={"ThreeEpB_1000_500": sample_size},
        #         demography=dem0, sequence_length=5000000, recombination_rate=1e-8)
        #     mts0 = msprime.sim_mutations(ts0, rate=1.5E-8)
        #     mts0.write_vcf(f0)
        #     tree_0 = ts0.first()
        #     with open(coalescent_1000_500, "w+") as g0:
        #         g0.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 1000_500.')
        #         for u in tree_0.nodes():
        #             # Retain coalescent nodes
        #             if not tree_0.is_leaf(u):  # skip sample nodes
        #                 g0.write(f"Node {u}, {tree_0.time(u)}\n")
        # with open(branch_length_1000_500, "w+") as h0:
        #     logger.info('Writing branch lengths for 1000_500.')
        #     h0.write('node_generations, branch_length\n')
        #     for u in tree_0.nodes():
        #         p = tree_0.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_0.time(p) - tree_0.time(u)
        #             h0.write(f"{tree_0.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_1000_1000, "w+") as f1:
        #     ts1 = msprime.sim_ancestry(samples={"ThreeEpB_1000_1000": sample_size},
        #         demography=dem1, sequence_length=5000000, recombination_rate=1e-8)
        #     mts1 = msprime.sim_mutations(ts1, rate=1.5E-8)
        #     mts1.write_vcf(f1)
        #     tree_1 = ts1.first()
        #     with open(coalescent_1000_1000, "w+") as g1:
        #         g1.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 1000_1000.')
        #         for u in tree_1.nodes():
        #             # Retain coalescent nodes
        #             if not tree_1.is_leaf(u):  # skip sample nodes
        #                 g1.write(f"Node {u}, {tree_1.time(u)}\n")
        # with open(branch_length_1000_1000, "w+") as h1:
        #     logger.info('Writing branch lengths for 1000_1000.')
        #     h1.write('node_generations, branch_length\n')
        #     for u in tree_1.nodes():
        #         p = tree_1.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_1.time(p) - tree_1.time(u)
        #             h1.write(f"{tree_1.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_1000_1500, "w+") as f2:
        #     ts2 = msprime.sim_ancestry(samples={"ThreeEpB_1000_1500": sample_size},
        #         demography=dem2, sequence_length=5000000, recombination_rate=1e-8)
        #     mts2 = msprime.sim_mutations(ts2, rate=1.5E-8)
        #     mts2.write_vcf(f2)
        #     tree_2 = ts2.first()
        #     with open(coalescent_1000_1500, "w+") as g2:
        #         g2.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 1000_1500.')
        #         for u in tree_2.nodes():
        #             # Retain coalescent nodes
        #             if not tree_2.is_leaf(u):  # skip sample nodes
        #                 g2.write(f"Node {u}, {tree_2.time(u)}\n")
        # with open(branch_length_1000_1500, "w+") as h2:
        #     logger.info('Writing branch lengths for 1000_1500.')
        #     h2.write('node_generations, branch_length\n')
        #     for u in tree_2.nodes():
        #         p = tree_2.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_2.time(p) - tree_2.time(u)
        #             h2.write(f"{tree_2.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_1000_2000, "w+") as f3:
        #     ts3 = msprime.sim_ancestry(samples={"ThreeEpB_1000_2000": sample_size},
        #         demography=dem3, sequence_length=5000000, recombination_rate=1e-8)
        #     mts3 = msprime.sim_mutations(ts3, rate=1.5E-8)
        #     mts3.write_vcf(f3)
        #     tree_3 = ts3.first()
        #     with open(coalescent_1000_2000, "w+") as g3:
        #         g3.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 1000_2000.')
        #         for u in tree_3.nodes():
        #             # Retain coalescent nodes
        #             if not tree_3.is_leaf(u):  # skip sample nodes
        #                 g3.write(f"Node {u}, {tree_3.time(u)}\n")
        # with open(branch_length_1000_2000, "w+") as h3:
        #     logger.info('Writing branch lengths for 1000_2000.')
        #     h3.write('node_generations, branch_length\n')
        #     for u in tree_3.nodes():
        #         p = tree_3.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_3.time(p) - tree_3.time(u)
        #             h3.write(f"{tree_3.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_500_2000, "w+") as f4:
        #     ts4 = msprime.sim_ancestry(samples={"ThreeEpB_500_2000": sample_size},
        #         demography=dem4, sequence_length=5000000, recombination_rate=1e-8)
        #     mts4 = msprime.sim_mutations(ts4, rate=1.5E-8)
        #     mts4.write_vcf(f4)
        #     tree_4 = ts4.first()
        #     with open(coalescent_500_2000, "w+") as g4:
        #         g4.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 1000_2000.')
        #         for u in tree_4.nodes():
        #             # Retain coalescent nodes
        #             if not tree_4.is_leaf(u):  # skip sample nodes
        #                 g4.write(f"Node {u}, {tree_4.time(u)}\n")
        # with open(branch_length_500_2000, "w+") as h4:
        #     logger.info('Writing branch lengths for 500_2000.')
        #     h4.write('node_generations, branch_length\n')
        #     for u in tree_4.nodes():
        #         p = tree_4.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_4.time(p) - tree_4.time(u)
        #             h4.write(f"{tree_4.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_1500_2000, "w+") as f5:
        #     ts5 = msprime.sim_ancestry(samples={"ThreeEpB_1500_2000": sample_size},
        #         demography=dem5, sequence_length=5000000, recombination_rate=1e-8)
        #     mts5 = msprime.sim_mutations(ts5, rate=1.5E-8)
        #     mts5.write_vcf(f5)
        #     tree_5 = ts5.first()
        #     with open(coalescent_1500_2000, "w+") as g5:
        #         g5.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 1500_2000.')
        #         for u in tree_5.nodes():
        #             # Retain coalescent nodes
        #             if not tree_5.is_leaf(u):  # skip sample nodes
        #                 g5.write(f"Node {u}, {tree_5.time(u)}\n")
        # with open(branch_length_1500_2000, "w+") as h5:
        #     logger.info('Writing branch lengths for 1500_2000.')
        #     h5.write('node_generations, branch_length\n')
        #     for u in tree_5.nodes():
        #         p = tree_5.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_5.time(p) - tree_5.time(u)
        #             h5.write(f"{tree_5.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_2000_2000, "w+") as f6:
        #     ts6 = msprime.sim_ancestry(samples={"ThreeEpB_2000_2000": sample_size},
        #         demography=dem6, sequence_length=5000000, recombination_rate=1e-8)
        #     mts6 = msprime.sim_mutations(ts6, rate=1.5E-8)
        #     mts6.write_vcf(f6)
        #     tree_6 = ts6.first()
        #     with open(coalescent_2000_2000, "w+") as g6:
        #         g6.write('Node, generations\n')
        #         logger.info('Writing coalescent times for TwoEpC.')
        #         for u in tree_6.nodes():
        #             # Retain coalescent nodes
        #             if not tree_6.is_leaf(u):  # skip sample nodes
        #                 g6.write(f"Node {u}, {tree_6.time(u)}\n")
        # with open(branch_length_2000_2000, "w+") as h6:
        #     logger.info('Writing branch lengths for 2000_2000.')
        #     h6.write('node_generations, branch_length\n')
        #     for u in tree_6.nodes():
        #         p = tree_6.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_6.time(p) - tree_6.time(u)
        #             h6.write(f"{tree_6.time(u)}, {branch_length}\n")
>>>>>>> Stashed changes

        # with open(output_ThreeEpB_100_50, "w+") as f7:
        #     ts7 = msprime.sim_ancestry(samples={"ThreeEpB_100_50": sample_size},
        #         demography=dem7, sequence_length=5000000, recombination_rate=1e-8)
        #     mts7 = msprime.sim_mutations(ts7, rate=1.5E-8)
        #     mts7.write_vcf(f7)
        #     tree_7 = ts7.first()
        #     with open(coalescent_100_50, "w+") as g7:
        #         g7.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 100_50.')
        #         for u in tree_7.nodes():
        #             # Retain coalescent nodes
        #             if not tree_7.is_leaf(u):  # skip sample nodes
        #                 g7.write(f"Node {u}, {tree_7.time(u)}\n")
        # with open(branch_length_100_50, "w+") as h7:
        #     logger.info('Writing branch lengths for 100_50.')
        #     h7.write('node_generations, branch_length\n')
        #     for u in tree_7.nodes():
        #         p = tree_7.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_7.time(p) - tree_7.time(u)
        #             h7.write(f"{tree_7.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_100_100, "w+") as f8:
        #     ts8 = msprime.sim_ancestry(samples={"ThreeEpB_100_100": sample_size},
        #         demography=dem8, sequence_length=5000000, recombination_rate=1e-8)
        #     mts8 = msprime.sim_mutations(ts8, rate=1.5E-8)
        #     mts8.write_vcf(f8)
        #     tree_8 = ts8.first()
        #     with open(coalescent_100_100, "w+") as g8:
        #         g8.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 100_100.')
        #         for u in tree_8.nodes():
        #             # Retain coalescent nodes
        #             if not tree_8.is_leaf(u):  # skip sample nodes
        #                 g8.write(f"Node {u}, {tree_8.time(u)}\n")
        # with open(branch_length_100_100, "w+") as h8:
        #     logger.info('Writing branch lengths for 100_100.')
        #     h8.write('node_generations, branch_length\n')
        #     for u in tree_8.nodes():
        #         p = tree_8.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_8.time(p) - tree_8.time(u)
        #             h8.write(f"{tree_8.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_100_150, "w+") as f9:
        #     ts9 = msprime.sim_ancestry(samples={"ThreeEpB_100_150": sample_size},
        #         demography=dem9, sequence_length=5000000, recombination_rate=1e-8)
        #     mts9 = msprime.sim_mutations(ts9, rate=1.5E-8)
        #     mts9.write_vcf(f9)
        #     tree_9 = ts9.first()
        #     with open(coalescent_100_150, "w+") as g9:
        #         g9.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 100_150.')
        #         for u in tree_9.nodes():
        #             # Retain coalescent nodes
        #             if not tree_9.is_leaf(u):  # skip sample nodes
        #                 g9.write(f"Node {u}, {tree_9.time(u)}\n")
        # with open(branch_length_100_150, "w+") as h9:
        #     logger.info('Writing branch lengths for 100_150.')
        #     h9.write('node_generations, branch_length\n')
        #     for u in tree_9.nodes():
        #         p = tree_9.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_9.time(p) - tree_9.time(u)
        #             h9.write(f"{tree_9.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_100_200, "w+") as f10:
        #     ts10 = msprime.sim_ancestry(samples={"ThreeEpB_100_200": sample_size},
        #         demography=dem10, sequence_length=5000000, recombination_rate=1e-8)
        #     mts10 = msprime.sim_mutations(ts10, rate=1.5E-8)
        #     mts10.write_vcf(f10)
        #     tree_10 = ts10.first()
        #     with open(coalescent_100_200, "w+") as g10:
        #         g10.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 100_200.')
        #         for u in tree_10.nodes():
        #             # Retain coalescent nodes
        #             if not tree_10.is_leaf(u):  # skip sample nodes
        #                 g10.write(f"Node {u}, {tree_10.time(u)}\n")
        # with open(branch_length_100_200, "w+") as h10:
        #     logger.info('Writing branch lengths for 100_200.')
        #     h10.write('node_generations, branch_length\n')
        #     for u in tree_10.nodes():
        #         p = tree_10.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_10.time(p) - tree_10.time(u)
        #             h10.write(f"{tree_10.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_50_200, "w+") as f11:
        #     ts11 = msprime.sim_ancestry(samples={"ThreeEpB_50_200": sample_size},
        #         demography=dem11, sequence_length=5000000, recombination_rate=1e-8)
        #     mts11 = msprime.sim_mutations(ts11, rate=1.5E-8)
        #     mts11.write_vcf(f11)
        #     tree_11 = ts11.first()
        #     with open(coalescent_50_200, "w+") as g11:
        #         g11.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 100_200.')
        #         for u in tree_11.nodes():
        #             # Retain coalescent nodes
        #             if not tree_11.is_leaf(u):  # skip sample nodes
        #                g11.write(f"Node {u}, {tree_11.time(u)}\n")
        # with open(branch_length_50_200, "w+") as h11:
        #     logger.info('Writing branch lengths for 50_200.')
        #     h11.write('node_generations, branch_length\n')
        #     for u in tree_11.nodes():
        #         p = tree_11.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_11.time(p) - tree_11.time(u)
        #             h11.write(f"{tree_11.time(u)}, {branch_length}\n")

        # with open(output_ThreeEpB_150_200, "w+") as f12:
        #     ts12 = msprime.sim_ancestry(samples={"ThreeEpB_150_200": sample_size},
        #         demography=dem12, sequence_length=5000000, recombination_rate=1e-8)
        #     mts12 = msprime.sim_mutations(ts12, rate=1.5E-8)
        #     mts12.write_vcf(f12)
        #     tree_12 = ts12.first()
        #     with open(coalescent_150_200, "w+") as g12:
        #         g12.write('Node, generations\n')
        #         logger.info('Writing coalescent times for 150_200.')
        #         for u in tree_12.nodes():
        #             # Retain coalescent nodes
        #             if not tree_12.is_leaf(u):  # skip sample nodes
        #                 g12.write(f"Node {u}, {tree_12.time(u)}\n")
        # with open(branch_length_150_200, "w+") as h12:
        #     logger.info('Writing branch lengths for 150_200.')
        #     h12.write('node_generations, branch_length\n')
        #     for u in tree_12.nodes():
        #         p = tree_12.parent(u)
        #         if p != tskit.NULL:
        #             branch_length = tree_12.time(p) - tree_12.time(u)
        #             h12.write(f"{tree_12.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_200_200, "w+") as f13:
            ts13 = msprime.sim_ancestry(samples={"ThreeEpB_200_200": sample_size},
                demography=dem13, sequence_length=5000000, recombination_rate=1e-8)
            mts13 = msprime.sim_mutations(ts13, rate=1.5E-7)
            mts13.write_vcf(f13)
            tree_13 = ts13.first()
            with open(coalescent_200_200, "w+") as g13:
                g13.write('Node, generations\n')
                logger.info('Writing coalescent times for TwoEpC.')
                for u in tree_13.nodes():
                    # Retain coalescent nodes
                    if not tree_13.is_leaf(u):  # skip sample nodes
                        g13.write(f"Node {u}, {tree_13.time(u)}\n")
        with open(branch_length_200_200, "w+") as h13:
            logger.info('Writing branch lengths for 200_200.')
            h13.write('node_generations, branch_length\n')
            for u in tree_13.nodes():
                p = tree_13.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_13.time(p) - tree_13.time(u)
                    h13.write(f"{tree_13.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_400_200, "w+") as f14:
            ts14 = msprime.sim_ancestry(samples={"ThreeEpB_400_200": sample_size},
                demography=dem14, sequence_length=5000000, recombination_rate=1e-8)
            mts14 = msprime.sim_mutations(ts14, rate=1.5E-7)
            mts14.write_vcf(f14)
            tree_14 = ts14.first()
            with open(coalescent_400_200, "w+") as g14:
                g14.write('Node, generations\n')
                logger.info('Writing coalescent times for TwoEpC.')
                for u in tree_14.nodes():
                    # Retain coalescent nodes
                    if not tree_14.is_leaf(u):  # skip sample nodes
                        g14.write(f"Node {u}, {tree_14.time(u)}\n")
        with open(branch_length_400_200, "w+") as h14:
            logger.info('Writing branch lengths for 400_200.')
            h14.write('node_generations, branch_length\n')
            for u in tree_14.nodes():
                p = tree_14.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_14.time(p) - tree_14.time(u)
                    h14.write(f"{tree_14.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_600_200, "w+") as f15:
            ts15 = msprime.sim_ancestry(samples={"ThreeEpB_600_200": sample_size},
                demography=dem15, sequence_length=5000000, recombination_rate=1e-8)
            mts15 = msprime.sim_mutations(ts15, rate=1.5E-7)
            mts15.write_vcf(f15)
            tree_15 = ts15.first()
            with open(coalescent_600_200, "w+") as g15:
                g15.write('Node, generations\n')
                logger.info('Writing coalescent times for TwoEpC.')
                for u in tree_15.nodes():
                    # Retain coalescent nodes
                    if not tree_15.is_leaf(u):  # skip sample nodes
                        g15.write(f"Node {u}, {tree_15.time(u)}\n")
        with open(branch_length_600_200, "w+") as h15:
            logger.info('Writing branch lengths for 600_200.')
            h15.write('node_generations, branch_length\n')
            for u in tree_15.nodes():
                p = tree_15.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_15.time(p) - tree_15.time(u)
                    h15.write(f"{tree_15.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_800_200, "w+") as f16:
            ts16 = msprime.sim_ancestry(samples={"ThreeEpB_800_200": sample_size},
                demography=dem16, sequence_length=5000000, recombination_rate=1e-8)
            mts16 = msprime.sim_mutations(ts16, rate=1.5E-7)
            mts16.write_vcf(f16)
            tree_16 = ts16.first()
            with open(coalescent_800_200, "w+") as g16:
                g16.write('Node, generations\n')
                logger.info('Writing coalescent times for TwoEpC.')
                for u in tree_16.nodes():
                    # Retain coalescent nodes
                    if not tree_16.is_leaf(u):  # skip sample nodes
                        g16.write(f"Node {u}, {tree_16.time(u)}\n")
        with open(branch_length_800_200, "w+") as h16:
            logger.info('Writing branch lengths for 800_200.')
            h16.write('node_generations, branch_length\n')
            for u in tree_16.nodes():
                p = tree_16.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_16.time(p) - tree_16.time(u)
                    h16.write(f"{tree_16.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_1000_200, "w+") as f17:
            ts17 = msprime.sim_ancestry(samples={"ThreeEpB_1000_200": sample_size},
                demography=dem17, sequence_length=5000000, recombination_rate=1e-8)
            mts17 = msprime.sim_mutations(ts17, rate=1.5E-7)
            mts17.write_vcf(f17)
            tree_17 = ts17.first()
            with open(coalescent_1000_200, "w+") as g17:
                g17.write('Node, generations\n')
                logger.info('Writing coalescent times for TwoEpC.')
                for u in tree_17.nodes():
                    # Retain coalescent nodes
                    if not tree_17.is_leaf(u):  # skip sample nodes
                        g17.write(f"Node {u}, {tree_17.time(u)}\n")
        with open(branch_length_1000_200, "w+") as h17:
            logger.info('Writing branch lengths for 1000_200.')
            h17.write('node_generations, branch_length\n')
            for u in tree_17.nodes():
                p = tree_17.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_17.time(p) - tree_17.time(u)
                    h17.write(f"{tree_17.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_1200_200, "w+") as f18:
            ts18 = msprime.sim_ancestry(samples={"ThreeEpB_1200_200": sample_size},
                demography=dem18, sequence_length=5000000, recombination_rate=1e-8)
            mts18 = msprime.sim_mutations(ts18, rate=1.5E-7)
            mts18.write_vcf(f18)
            tree_18 = ts18.first()
            with open(coalescent_1200_200, "w+") as g18:
                g18.write('Node, generations\n')
                logger.info('Writing coalescent times for TwoEpC.')
                for u in tree_18.nodes():
                    # Retain coalescent nodes
                    if not tree_18.is_leaf(u):  # skip sample nodes
                        g18.write(f"Node {u}, {tree_18.time(u)}\n")
        with open(branch_length_1200_200, "w+") as h18:
            logger.info('Writing branch lengths for 1200_200.')
            h18.write('node_generations, branch_length\n')
            for u in tree_18.nodes():
                p = tree_18.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_18.time(p) - tree_18.time(u)
                    h18.write(f"{tree_18.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_1400_200, "w+") as f19:
            ts19 = msprime.sim_ancestry(samples={"ThreeEpB_1400_200": sample_size},
                demography=dem19, sequence_length=5000000, recombination_rate=1e-8)
            mts19 = msprime.sim_mutations(ts19, rate=1.5E-7)
            mts19.write_vcf(f19)
            tree_19 = ts19.first()
            with open(coalescent_1400_200, "w+") as g19:
                g19.write('Node, generations\n')
                logger.info('Writing coalescent times for TwoEpC.')
                for u in tree_19.nodes():
                    # Retain coalescent nodes
                    if not tree_19.is_leaf(u):  # skip sample nodes
                        g19.write(f"Node {u}, {tree_19.time(u)}\n")
        with open(branch_length_1400_200, "w+") as h19:
            logger.info('Writing branch lengths for 1400_200.')
            h19.write('node_generations, branch_length\n')
            for u in tree_19.nodes():
                p = tree_19.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_19.time(p) - tree_19.time(u)
                    h19.write(f"{tree_19.time(u)}, {branch_length}\n")

        with open(output_ThreeEpB_1600_200, "w+") as f20:
            ts20 = msprime.sim_ancestry(samples={"ThreeEpB_1600_200": sample_size},
                demography=dem20, sequence_length=5000000, recombination_rate=1e-8)
            mts20 = msprime.sim_mutations(ts20, rate=1.5E-7)
            mts20.write_vcf(f20)
            tree_20 = ts20.first()
            with open(coalescent_1600_200, "w+") as g20:
                g20.write('Node, generations\n')
                logger.info('Writing coalescent times for TwoEpC.')
                for u in tree_20.nodes():
                    # Retain coalescent nodes
                    if not tree_20.is_leaf(u):  # skip sample nodes
                        g20.write(f"Node {u}, {tree_20.time(u)}\n")
        with open(branch_length_1600_200, "w+") as h20:
            logger.info('Writing branch lengths for 1600_200.')
            h20.write('node_generations, branch_length\n')
            for u in tree_20.nodes():
                p = tree_20.parent(u)
                if p != tskit.NULL:
                    branch_length = tree_20.time(p) - tree_20.time(u)
                    h20.write(f"{tree_20.time(u)}, {branch_length}\n")




        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    msPrimeSimulate().main()
