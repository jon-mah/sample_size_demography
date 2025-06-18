""" Computes summary statistics for a given SFS in Dadi format.

JCM 20250617
"""


import sys
import os
import logging
import argparse

import dadi


class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class computeSFSSummaryStatistics():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)

    def computeSFSSummaryStatisticsParser(self):
        """Return *argparse.ArgumentParser* for ``fitdadi_infer_DFE.py``."""
        parser = ArgumentParserNoArgHelp(
            description=(
                'Given the number of individuals in population one and two, '
                'this script inputs a `*pops_file.txt` in the format '
                'specified for use by the python package, `easySFS.py`.'),
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument(
            'input_sfs', type=str,
            help='An SFS in Dadi format to compute summary statistics for.')
        parser.add_argument(
            'outprefix', type=str,
            help='The file prefix for the input files')
        return parser

    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.computeSFSSummaryStatisticsParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
        input_sfs = args['input_sfs']
        input_spectrum = dadi.Spectrum.fromfile(input_sfs)
        outprefix = args['outprefix']

        # create input directory if needed
        outdir = os.path.dirname(args['outprefix'])
        if outdir:
            if not os.path.isdir(outdir):
                if os.path.isfile(outdir):
                    os.remove(outdir)
                os.mkdir(outdir)

        # input files: logfile
        # Remove input files if they already exist
        underscore = '' if args['outprefix'][-1] == '/' else '_'
        logfile = '{0}{1}summary.txt'.format(args['outprefix'], underscore)
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
        
        logger.info('Calculating summary statistics.')
        logger.info("Watterson's Theta: {0}".format(input_spectrum.Watterson_theta()))
        logger.info("Nucleotide Diverisity: {0}".format(input_spectrum.pi()))
        logger.info("Tajima's D: {0}".format(input_spectrum.Tajima_D()))
        logger.info("Zeng's E: {0}".format(input_spectrum.Zengs_E()))
        logger.info("Zeng's Theta_L: {0}".format(input_spectrum.theta_L()))
        logger.info('Pipeline executed succesfully.')



if __name__ == "__main__":
    computeSFSSummaryStatistics().main()
