"""
Computes the empirical SFS from the processed gnomAD v4.1 data used in DR EVIL.

JCM 20241226
"""


import sys
import os
import logging
import time
import argparse
import warnings
import random

import numpy as np
import pandas as pd
import dadi

class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class ComputeEmpiricalGnomADSFS():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)

    def computeEmpiricalGnomADSFSParser(self):
        """Return *argparse.ArgumentParser* for ``fitdadi_infer_DFE.py``."""
        parser = ArgumentParserNoArgHelp(
            description=(
                'Computes a downsampled SFS for a given species.'),
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument(
            'outprefix', type=str,
            help='The file prefix for the output files')
        return parser


    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.computeEmpiricalGnomADSFSParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
        outprefix = args['outprefix']

        # Numpy options
        np.set_printoptions(linewidth=np.inf)

        # create output directory if needed
        outdir = os.path.dirname(args['outprefix'])
        if outdir:
            if not os.path.isdir(outdir):
                if os.path.isfile(outdir):
                    os.remove(outdir)
                os.mkdir(outdir)

        # Output files: logfile, snp_matrix.csv
        # Remove output files if they already exist
        underscore = '' if args['outprefix'][-1] == '/' else '_'
        empirical_sfs = \
           '{0}{1}gnomAD_empirical_syn_sfs.txt'.format(
                args['outprefix'], underscore)
        logfile = '{0}{1}compute_gnomAD_sfs.log'.format(
            args['outprefix'], underscore)
        to_remove = [logfile, empirical_sfs]
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

        # Load the data from the .tsv file
        # file_path = '../Data/gnomAD_sfs.tsv.txt'
        file_path = '..Data/full_sfs.tsv.gz'

        logger.info('Loading in data')
        data = pd.read_csv(file_path, sep='\t', compression='gzip')
        logger.info('Data succesfully loaded in')
        # Group by the desired column
        grouped_df = df.groupby('AC_nfe')

        # Perform an aggregation on the grouped data (e.g., calculate the sum)
        result = grouped_df.count()

        # Initialize an array of zeros with length 1001
        # allele_frequency_sum = np.zeros(1001)

        # Iterate through the DataFrame and sum up 'n' for each 'AC'
        # for _, row in data.iterrows():
        #     ac_value = row['AC']
        #     n_value = row['n']
        #     allele_frequency_sum[ac_value] += n_value

        # Print the resulting array
        # for i in range(25):
        #     print('There are ' + str(int(allele_frequency_sum[i])) + ' ' + str(i) + '-tons.')

        # print('There are ' + str(int(allele_frequency_sum[25:].sum())) + ' higher frequency variants.')

        # syn_data = dadi.Spectrum(data=allele_frequency_sum)
        # syn_data = syn_data.fold()
        # syn_data.to_file(empirical_sfs)
        # logger.info('Finished downsampling.')
        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    ComputeEmpiricalGnomADSFS().main()
