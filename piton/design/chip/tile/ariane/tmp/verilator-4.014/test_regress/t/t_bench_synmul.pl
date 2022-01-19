#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

scenarios(simulator => 1);

top_filename("t/t_math_synmul.v");

$Self->{cycles} = $Self->{benchmark}||0;
$Self->{cycles} = 100 if $Self->{cycles}<100;

$Self->{sim_time} = $Self->{cycles}*100;

compile(
    v_flags2 => ["+define+SIM_CYCLES=$Self->{cycles}",
                 "--stats",
                 "-Wno-UNOPTTHREADS"],
    );

execute(
    check_finished => 1,
    );

ok(1);
1;
