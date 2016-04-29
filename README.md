brett.schellenberg@gmail.com

Introduction
============
Welcome to parselog, a command line utility for statistical reports on apache logs.

Installation
============
required perl modules

Name              | Location  | Description
------------------|-----------|------------|
`UAParser.pm`     | included  | perl5 port of existing javascript library, for pulling data out of a User Agent string
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

    Usage: ./parselog <filename> [options]
     Parse an apache log file and rollup results with output similar to uniq -c, for use with graph utility.

     <filename>                   apache access log to parse. defaults to ./small-sample.log

     --rollup=COLUMN1[,COLUMN2]   rollup requests by day, COLUMN1, and COLUMN2. COLUMN one or two comma-separated values:
                              CLIENTIP, IDENTD, HTTPUSER, PROCESSDATE, REQUEST, SERVERSTATUSCODE, RESPONSESIZE, REFERER,
                              USERAGENT, OS, OSNAME, OSVERSION, HTTPMETHOD, HTTPRESOURCE, HTTPVERSION

     --limit=limit1[,limit2]      may be used to limit the amount of output. limit1 will limit COLUMN1. limit2 will limit
                              COLUMN2. 0 means unlimited.

     --indented                   suppress normal graph-friendly output, instead output as an indented tree. indent mode also
                              prevents the truncation of long values which occurs in graph-friendly mode.

     --percent                    report counts as percentages. this only operates on the innermost counts; category counts will
                              not be affected.

     --unparsed                   include _UNPARSED_ records in output. these are usually from unparsed dates. defaults to false.
     --skipunknownOS              skip over records with unknown OS. these tend to be bots/spiders. defaults to false.
     --verbose                    output extra information, like when a record fails to parse.

     --help                       display this message

    typical usage cases:

    What are the number of requests served by day?
    ./parselog --indented

    What are the 3 most frequent UserAgents by day?
    ./parselog --rollup=USERAGENT --limit=3 --indented

    Show a graph of the 3 most frequent UserAgents by day.
    ./parselog --rollup=USERAGENT --limit=3 | graph

    What is the percentage of GET's and POST's by OS by day?
    ./parselog --rollup=OS,HTTPMETHOD --percent --indented

    Show a graph of OSNAME and OSVERSION usage by day (only for known OSes)
    ./parselog --rollup=OSNAME,OSVERSION --skipunknownOS | graph

    Or maybe you want to see the ridiculous multitude of USERAGENT strings spewed out by the same OS...
    ./parselog --rollup=OS,USERAGENT --skipunknownOS --indented


Examples
========

    >parseapachelog pabo$ parselog --rollup=USERAGENT --limit=3 | graph
    processing log file small-sample.log...
    DATE: 2011-12-01 (2822)
    2011-12-01 | Mozilla/5.0 (compatible; Googlebot/2.1; +http://www....: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx (456)
    2011-12-01 | Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.y...: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx (324)
    2011-12-01 | Mozilla/5.0 (compatible; Ezooms/1.0; ezooms.bot@gmai...: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx (245)

    DATE: 2011-12-02 (2572)
    2011-12-02 | Mozilla/5.0 (compatible; Googlebot/2.1; +http://www....: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx (364)
    2011-12-02 | Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.y...: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx (281)
    2011-12-02 | Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bi...: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx (178)

    DATE: 2011-12-03 (604)
    2011-12-03 | Mozilla/5.0 (compatible; Googlebot/2.1; +http://www....: xxxxxxxxxxxxxxxxxxxxxxxxxxxxx (142)
    2011-12-03 | Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.y...: xxxxxxxxxxxxxx (68)
    2011-12-03 | Mozilla/5.0 (compatible; Baiduspider/2.0; +http://ww...: xxxxxxxx (36)


    >:parseapachelog pabo$ parselog --rollup=HTTPMETHOD --percent --indented
    processing log file small-sample.log...
    DATE: 2011-12-01 (2822)
        HTTPMETHOD: GET (90.53%)
        HTTPMETHOD: POST (9.42%)
        HTTPMETHOD: HEAD (0.03%)

    DATE: 2011-12-02 (2572)
        HTTPMETHOD: GET (88.95%)
        HTTPMETHOD: POST (10.73%)
        HTTPMETHOD: HEAD (0.31%)

    DATE: 2011-12-03 (604)
        HTTPMETHOD: GET (88.74%)
        HTTPMETHOD: POST (10.92%)
        HTTPMETHOD: HEAD (0.33%)


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
