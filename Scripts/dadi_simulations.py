""" Uses Dadi to simulate five demographic scenarios.

JCM 20240207
"""


import sys
import os
import logging
import time
import argparse
import warnings

import dadi


class ArgumentParserNoArgHelp(argparse.ArgumentParser):
    """Like *argparse.ArgumentParser*, but prints help when no arguments."""

    def error(self, message):
        """Print error message, then help."""
        sys.stderr.write('error: %s\n\n' % message)
        self.print_help()
        sys.exit(2)


class DadiSimulate():
    """Wrapper class to allow functions to reference each other."""

    def ExistingFile(self, fname):
        """Return *fname* if existing file, otherwise raise ValueError."""
        if os.path.isfile(fname):
            return fname
        else:
            raise ValueError("%s must specify a valid file name" % fname)

    def DadiSimulateParser(self):
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
            'outprefix', type=str,
            help='The file prefix for the output files')
        return parser

    def snm(self, notused, ns, pts):
        """Return a standard neutral model.

        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        # Construct Spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def two_epoch(self, params, ns, pts):
        """Define a two-epoch demography, i.e., an instantaneous size change.

        params = (nu, T)
            nu: Ratio of contemporary to ancient population size.
            T: Time in the past at which size change occured,
                in units of 2*N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        nu, T = params  # Define given parameters.
        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        phi = dadi.Integration.one_pop(phi, xx, T, nu)  # Integrate.

        # Construct Spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx,))
        return fs

    def two_epoch_sel(self, params, ns, pts):
        """Define a two-epoch demography, i.e., an instantaneous size change.

        This method incorporates a gamma parameter.

        params = (nu, T, gamma)
            nu: Ratio of contemporary to ancient population size.
            T: Time in the past at which size change occured,
                in units of 2*N_a.
            gamma: Parameter tuple describing a gamma distribution.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        nu, T, gamma = params  # Define given parameters.
        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx, gamma=gamma)  # Define initial phi

        phi = dadi.Integration.one_pop(phi, xx, T, nu, gamma=gamma)

        # Construct Spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def growth(self, params, ns, pts):
        """Exponential growth beginning some time ago.

        params = (nu, T)
            nu: Ratio of contemporary to ancient population size.
            T: Time in the past at which size change occured,
                in units of 2*N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        nu, T = params  # Define given parameters.
        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        def nu_func(t): return numpy.exp(numpy.log(nu) * t / T)  # Exp growth.
        phi = dadi.Integration.one_pop(phi, xx, T, nu_func)  # Integrate.

        # Construct Spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def bottlegrowth(self, params, ns, pts):
        """Instantaneous size change followed by exponential growth.

        params = (nuB, nuF, T)
            nuB: Ratio of population size after instantaneous change to ancient
                population size.
            nuF: Ratio of contemporary to ancient population size.
            T: Time in the past at which size change occured,
                in units of 2*N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        nuB, nuF, T = params  # Define given parameters.

        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi

        # Exponential growth function
        def nu_func(t): return nuB * numpy.exp(numpy.log(nuF / nuB) * t / T)

        phi = dadi.Integration.one_pop(phi, xx, T, nu_func)  # Integrate.

        # Construct Spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def three_epoch(self, params, ns, pts):
        """Define a three-epoch demography.

        params = (nuB, nuF, TB, TF)
            nuB: Ratio of bottleneck population size to ancient
                population size.
            nuF: Ratio of contemporary to ancient population size.
            TB: Length of bottleneck, in units of 2 * N_a.
            TF: Time since bottleneck recovery, in units of 2 * N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        nuB, nuF, TB, TF = params  # Define given parameters.

        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        phi = dadi.Integration.one_pop(phi, xx, TB, nuB)  # Integrate 1 to 2.
        phi = dadi.Integration.one_pop(phi, xx, TF, nuF)  # Integrate 2 to 3.

        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def four_epoch(self, params, ns, pts):
        """Define a four-epoch demography.

        params = (Na, Nb, Nc, Ta, Tb, Tc)
            Na: ratio of population size between epoch 1 and 2.
            Nb: ratio of population size between epoch 2 and 3.
            Nc: ratio of population size between epoch 3 and 4.
            Ta: Bottleneck length between epoch 1 and 2, in units of 2 * N_a.
            Tb: Length of bottleneck between epoch 2 and 3,
                in units of 2 * N_a.
            Tc: Length of bottleneck between epoch 3 and 4,
                in units of 2 * N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        Na, Nb, Nc, Ta, Tb, Tc = params  # Define given parameters.

        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        # Integrate epochs.
        phi = dadi.Integration.one_pop(phi, xx, Ta, Na)  # Integrate 1 to 2.
        phi = dadi.Integration.one_pop(phi, xx, Tb, Nb)  # Integrate 2 to 3.
        phi = dadi.Integration.one_pop(phi, xx, Tc, Nc)  # Integrate 3 to 4.

        # Construct spectrum object.
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs

    def one_epoch(self, params, ns, pts):
        """Define a one-epoch demography.
        params = (nu, T)
            nu: Ratio of contemporary to ancient population size.
            T: Time in the past at which size change occured,
                in units of 2*N_a.
        ns = (n1, )
            n1: Number of samples in resulting Spectrum object.
        pts: Number of grid points to use in integration.
        """
        xx = dadi.Numerics.default_grid(pts)  # Define likelihood surface.
        phi = dadi.PhiManip.phi_1D(xx)  # Define initial phi.

        # Construct spectrum object
        fs = dadi.Spectrum.from_phi(phi, ns, (xx, ))
        return fs


    def one_pop(self, phi, xx, T, nu=1, gamma=0, h=0.5, theta0=1.0, initial_t=0,
                frozen=False, beta=1):
        """
        Integrate a 1-dimensional phi forward.

        phi: Initial 1-dimensional phi
        xx: Grid upon (0,1) over which phi is defined.

        nu, gamma, and theta0 may be functions of time.
        nu: Population size
        gamma: Selection coefficient on *all* segregating alleles
        h: Dominance coefficient. h = 0.5 corresponds to genic selection.
        Heterozygotes have fitness 1+2sh and homozygotes have fitness 1+2s.
        theta0: Proportional to ancestral size. Typically constant.
        beta: Breeding ratio, beta=Nf/Nm.

        T: Time at which to halt integration
        initial_t: Time at which to start integration. (Note that this only
            matters if one of the demographic parameters is a function of time.)

        frozen: If True, population is 'frozen' so that it does not change.
            In the one_pop case, this is equivalent to not running the
            integration at all.
        """
        phi = phi.copy()

        # For a one population integration, freezing means just not integrating.
        if frozen:
            return phi

        if T - initial_t == 0:
            return phi
        elif T - initial_t < 0:
            raise ValueError('Final integration time T (%f) is less than '
                             'initial_time (%f). Integration cannot be run '
                             'backwards.' % (T, initial_t))

        vars_to_check = (nu, gamma, h, theta0, beta)
        if numpy.all([numpy.isscalar(var) for var in vars_to_check]):
            return dadi.Integration._one_pop_const_params(phi, xx, T, nu, gamma, h, theta0,
                                         initial_t, beta)

        nu_f = dadi.Misc.ensure_1arg_func(nu)
        gamma_f = dadi.Misc.ensure_1arg_func(gamma)
        h_f = dadi.Misc.ensure_1arg_func(h)
        theta0_f = dadi.Misc.ensure_1arg_func(theta0)
        beta_f = dadi.Misc.ensure_1arg_func(beta)

        current_t = initial_t
        nu, gamma, h = nu_f(current_t), gamma_f(current_t), h_f(current_t)
        beta = beta_f(current_t)
        dx = numpy.diff(xx)
        while current_t < T:
            dt = _compute_dt(dx, nu, [0], gamma, h)
            this_dt = min(dt, T - current_t)

            # Because this is an implicit method, I need the *next* time's params.
            # So there's a little inconsistency here, in that I'm estimating dt
            # using the last timepoints nu, gamma, h.
            next_t = current_t + this_dt
            nu, gamma, h = nu_f(next_t), gamma_f(next_t), h_f(next_t)
            beta = beta_f(next_t)
            theta0 = theta0_f(next_t)

            if numpy.any(numpy.less([T, nu, theta0], 0)):
                raise ValueError('A time, population size, migration rate, or '
                                 'theta0 is < 0. Has the model been mis-specified?')
            if numpy.any(numpy.equal([nu], 0)):
                raise ValueError('A population size is 0. Has the model been '
                                 'mis-specified?')

            _inject_mutations_1D(phi, this_dt, xx, theta0)
            # Do each step in C, since it will be faster to compute the a, b, c
            # matrices there.
            phi = dadi.Integration.int_c.implicit_1Dx(phi, xx, nu, gamma, h, beta, this_dt,
                                                      use_delj_trick=False)
            current_t = next_t
        return phi

    def compute_allele_sum(self, file_path):
        """Return sum of allele counts from input SFS file.
        """
        with open(file_path, 'r') as file:
             lines = file.readlines()
             if len(lines) >= 2:
                 second_line = lines[1].strip()
                 values = list(map(float, second_line.split()))
                 array_sum = sum(values)
                 return array_sum


    def main(self):
        """Execute main function."""
        # Parse command line arguments
        parser = self.DadiSimulateParser()
        args = vars(parser.parse_args())
        prog = parser.prog

        # Assign arguments
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
        logfile = '{0}{1}{2}.log'.format(args['outprefix'], underscore, sample_size)
        output_TwoEpC = '{0}{1}TwoEpochContraction_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_TwoEpE = '{0}{1}TwoEpochExpansion_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_ThreeEpC = '{0}{1}ThreeEpochContraction_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_ThreeEpE = '{0}{1}ThreeEpochExpansion_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_ThreeEpB = '{0}{1}ThreeEpochBottleneck_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_500_2000 = '{0}{1}500_2000_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_1000_2000 = '{0}{1}1000_2000_{2}.sfs'.format(   
            args['outprefix'], underscore, sample_size)
        output_1500_2000 = '{0}{1}1500_2000_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_2000_2000 = '{0}{1}2000_2000_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_2500_2000 = '{0}{1}2500_2000_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_1000_500 = '{0}{1}1000_500_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_1000_1000   = '{0}{1}1000_1000_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_1000_1500 = '{0}{1}1000_1500_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_1000_2500 = '{0}{1}1000_2500_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
        output_snm = '{0}{1}snm_{2}.sfs'.format(
            args['outprefix'], underscore, sample_size)
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

        # Initialize demographic scenario parameters
        mu = 1.5E-8  # Mutation rate per generation
        N_e = 10000  # Effective population size
        theta = N_e * mu * 4 * 100000000

        with open(output_TwoEpC, "w+") as f0:
            """Simulate a two-epoch contraction."""
            nu = 0.5
            tau = 0.1 # 2000 generations
            output_spectrum = theta * self.two_epoch(
                params=(nu, tau), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f0)
            logger.info('Finished generating two-epoch contraction.')

        with open(output_TwoEpE, "w+") as f1:
            """Simulate a two-epoch expansion."""
            nu = 2.0
            tau = 0.01 # 200 generations
            output_spectrum = theta * self.two_epoch(
                params=(nu, tau), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f1)
            logger.info('Finished generating two-epoch expansion.')

        with open(output_ThreeEpC, "w+") as f2:
            """Simulate a three-epoch contraction."""
            nuB = 0.5  # Bottleneck relative size
            nuF = 0.25  # Concurrent relative size
            tauB = 0.09  # Bottleneck duration, 1800 generations
            tauF = 0.01  # Time since bottleneck recovery, 200 generations
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f2)
            logger.info('Finished generating three-epoch contraction.')

        with open(output_ThreeEpE, "w+") as f3:
            """Simulate a three-epoch expansion."""
            nuB = 2.0  # Bottleneck relative size
            nuF = 4.0  # Concurrent relative size
            tauB = 0.09  # Bottleneck duration, 1800 generations
            tauF = 0.01  # Time since bottleneck recovery, 200 generations
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f3)
            logger.info('Finished generating three-epoch expansion.')

        with open(output_ThreeEpB, "w+") as f4:
            """Simulate a three-epoch bottleneck."""
            nuB = 0.1  # Bottleneck relative size
            nuF = 5.0  # Concurrent relative size
            tauB = 0.09  # Bottleneck duration
            tauF = 0.01  # Time since bottleneck recovery
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f4)
            logger.info('Finished generating three-epoch bottleneck.')

        with open(output_500_2000, "w+") as f5:
            """Simulate a three-epoch bottleneck."""
            nuB = 0.1 # Bottleneck relative size
            nuF = 5.0 # Concurrent relative size
            tauB = 0.025 # Bottleneck duration
            tauF = 0.1 # Time since bottleneck recovery
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f5)
            logger.info('Finished generating 500-2000 bottleneck.')

        with open(output_1000_2000, "w+") as f6:
            """Simulate a three-epoch bottleneck."""
            nuB = 0.1 # Bottleneck relative size
            nuF = 5.0 # Concurrent relative size
            tauB = 0.05 # Bottleneck duration
            tauF = 0.1 # Time since bottleneck recovery
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f6)
            logger.info('Finished generating 1000-2000 bottleneck.')

        with open(output_1500_2000, "w+") as f7:
            """Simulate a three-epoch bottleneck."""
            nuB = 0.1 # Bottleneck relative size
            nuF = 5.0 # Concurrent relative size
            tauB = 0.075 # Bottleneck duration
            tauF = 0.1 # Time since bottleneck recovery
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f7)
            logger.info('Finished generating 1500-2000 bottleneck.')
        
        with open(output_2000_2000, "w+") as f8:
            """Simulate a three-epoch bottleneck."""
            nuB = 0.1 # Bottleneck relative size
            nuF = 5.0 # Concurrent relative size
            tauB = 0.1 # Bottleneck duration
            tauF = 0.1 # Time since bottleneck recovery
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f8)
            logger.info('Finished generating 2000-2000 bottleneck.')

        with open(output_2500_2000, "w+") as f9:
            """Simulate a three-epoch bottleneck."""
            nuB = 0.1 # Bottleneck relative size
            nuF = 5.0 # Concurrent relative size
            tauB = 0.125 # Bottleneck duration
            tauF = 0.1 # Time since bottleneck recovery
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f9)
            logger.info('Finished generating 2500-2000 bottleneck.')

        with open(output_1000_500, "w+") as f10:
            """Simulate a three-epoch bottleneck."""
            nuB = 0.1 # Bottleneck relative size
            nuF = 5.0 # Concurrent relative size
            tauB = 0.05 # Bottleneck duration
            tauF = 0.025 # Time since bottleneck recovery
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f10)
            logger.info('Finished generating 1000-500 bottleneck.')

        with open(output_1000_1000, "w+") as f11:
            """Simulate a three-epoch bottleneck."""
            nuB = 0.1 # Bottleneck relative size
            nuF = 5.0 # Concurrent relative size
            tauB = 0.05 # Bottleneck duration
            tauF = 0.05 # Time since bottleneck recovery
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f11)
            logger.info('Finished generating 1000-1000 bottleneck.')
        
        with open(output_1000_1500, "w+") as f12:
            """Simulate a three-epoch bottleneck."""
            nuB = 0.1 # Bottleneck relative size
            nuF = 5.0 # Concurrent relative size
            tauB = 0.05 # Bottleneck duration
            tauF = 0.075 # Time since bottleneck recovery
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f12)
            logger.info('Finished generating 1000-1500 bottleneck.')

        with open(output_1000_2500, "w+") as f13:
            """Simulate a three-epoch bottleneck."""
            nuB = 0.1 # Bottleneck relative size
            nuF = 5.0 # Concurrent relative size
            tauB = 0.05 # Bottleneck duration
            tauF = 0.125 # Time since bottleneck recovery
            output_spectrum = theta * self.three_epoch(
                params=(nuB, nuF, tauB, tauF), ns=(sample_size,), pts=1000)
            output_spectrum.fold().to_file(f13)
            logger.info('Finished generating 1000-2500 bottleneck.')

        with open(output_snm, "w+") as f14:
            """Simulate a standard neutral model."""
            output_spectrum = theta * self.snm(
                notused=None, ns=(sample_size, ), pts=1000)
            output_spectrum.fold().to_file(f14)
            logger.info('Finished generating standard neutral model.')

        logger.info('Finished generating all demographic scenarios.')
        logger.info('Pipeline executed succesfully.')


if __name__ == '__main__':
    DadiSimulate().main()
