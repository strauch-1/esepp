#! /usr/bin/perl
use strict;
use warnings;

my $code = "./esepp";
my @mom = (115, 116, 161, 162, 210, 211);
my @theta = (20, 40, 60, 80, 100);
my @pid = (3, 6);  # 3 = both e- and e+, 6 = both, mu- and mu+

my $million = 1000000;
my $N = 20 * $million;

my ($argv_mom) = @ARGV;
if (defined $argv_mom) {
    @mom = ($argv_mom);
}

foreach
    my $mom(@mom)
    {
        foreach
            my $theta(@theta)
            {
                foreach
                    my $pid(@pid)
                    {
                        my $m = 0.511;
                        if ($pid >= 4 || $pid <= 6) {
                            $m = 105.65837;
                        };
                        my $dtheta = 2;
                        my $theta_min = $theta - $dtheta;
                        my $theta_max = $theta + $dtheta;
                        my $e = sqrt($mom * $mom + $m * $m);
                        my $emax = $e - $m - 0.5;

                        my $arg = $pid."\n";    # type of scattered lepton
                        $arg = $arg."2"."\n";   # rosenbluth events (2 = no)
                        $arg = $arg."3"."\n";   # form factor (3 = Kelly)
                        $arg = $arg."12"."\n";  # 12 = accurate QED calculation, all the terms
                        $arg = $arg."3"."\n";   #  3 = full vacuum polarization correction
                        $arg = $arg."1"."\n";   # TPE: 1 = approach of Mo & Tsai

                        $arg = $arg.sprintf("%.1f", $e)."\n";  # Full energy of incident leptons
                        $arg = $arg."1"."\n";  # Cut-off energy for bremsstrahlung photons
                        $arg = $arg.sprintf("%.1f", $emax)."\n";  # Maximum energy for bremsstrahlung photons

                        $arg = $arg."2"."\n";  # 2 = specify any angular range
                        $arg = $arg.$theta_min."\n";
                        $arg = $arg.$theta_max."\n";

                        $arg = $arg."2"."\n";  # 2 = -180 < PHI < 180
                        $arg = $arg."-180"."\n";
                        $arg = $arg."180"."\n";
                        $arg = $arg.$N."\n";
                        $arg = $arg."2"."\n";  # 2 = *.root files

                        $arg = $arg.sprintf("esepp_%03dMeV_%03deg\n", $mom, $theta);  # prefix for the output files
                        print $arg."\n";

                        my $cmd = "printf \"$arg\" | $code";
                        my $output = `$cmd`;
                        print $output."\n\n";
                    }
            }
    }
