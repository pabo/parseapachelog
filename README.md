brett.schellenberg@gmail.com

Introduction
============
Welcome to parselog, a command line utility for statistical reports on apache logs.

Installation
============
required perl modules

Name              | Location  | Description
------------------+-----------+------------
`UAParser.pm`     | included  | perl5 port of existing library, for pulling data out of a User Agent string
`Getopt/Long.pm`  | CPAN      | for parsing command line options
`Text/CSV.pm`     | CPAN      | CSV parsing
`Text/CSV_XS.pm`  | CPAN      | significantly speeds up CSV parsing (not strictly -required-)


Graph utility
=============
Also included is a simple command line graphing utility. It accepts input in the style of
uniq -c's output and creates a bar graph of the results. It's a great visual aid for simple
count information. The graph utility requires two additional perl modules: Term::ReadKey and
POSIX. POSIX should be installed on most systems already and Term::ReadKey is available on CPAN.


Usage
=====
Use the --help option to display detailed usage information
> parselog --help


Copyright
=========
Copyright (c) 2014 Brett Schellenberg <brett.schellenberg@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
