#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2009 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

scenarios(vlt => 1);

compile(
    v_flags => ['--cdc'],
    verilator_make_gcc => 0,
    make_top_shell => 0,
    make_main => 0,
    fails => 1,
    expect_filename => $Self->{golden_filename},
    );

file_grep("$Self->{obj_dir}/V$Self->{name}__cdc.txt", qr/CDC Report/);

ok(1);
1;
