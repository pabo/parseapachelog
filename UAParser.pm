package UAParser;
# brett.schellenberg@gmail.com
# perl 5 port of javascript component/user-agent-parser found at https://github.com/component/user-agent-parser
#  - perl port of OS portion
#  - minor tweaks
#  - added a few user agent regexes
#
#
# License
#
# Dual licensed under GPLv2 & MIT
#
# Copyright © 2012-2013 Faisalman <fyzlman@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# https://github.com/component/user-agent-parser

use strict;
use warnings;

sub getOSFromUserAgent {
	my $ua = shift @_;

	my $regexes =  [
		# Windows based
		[
			qr/(windows)\snt\s6\.2;\s(arm)/i,                                     # Windows RT
			qr/(windows\sphone(?:\sos)*|windows\smobile|windows)[\s\/]?([ntce\d\.\s]+\w)/i
		], ['NAME', 'VERSION'],

		[ qr/(win(?=3|9|n)|win\s9x\s)([nt\d\.]+)/i ],
		[['NAME', 'Windows'], 'VERSION'],

		# Mobile/Embedded OS
		[ qr/\((bb)(10);/i ],                                                     # BlackBerry 10
		[['NAME', 'BlackBerry'], 'VERSION'],

		[
			qr/(blackberry)\w*\/?([\w\.]+)*/i,                                    # Blackberry
			qr/(tizen)\/([\w\.]+)/i,                                              # Tizen
			qr/(android|webos|palm\sos|qnx|bada|rim\stablet\sos|meego)[\/\s-]?([\w\.]+)*/i # Android/WebOS/Palm/QNX/Bada/RIM/MeeGo
		],
		['NAME', 'VERSION'],

		[ qr/(SonyEricsson)(\w+)/i ],                                              # Sony Ericsson
		[['NAME', 'Sony Ericsson'], 'VERSION'],

		[ qr/(symbian\s?os|symbos|s60(?=;))[\/\s-]?([\w\.]+)*/i ],                 # Symbian
		[['NAME', 'Symbian'], 'VERSION'],

		[ qr/mozilla.+\(mobile;.+gecko.+firefox/i ],                               # Firefox OS
		[['NAME', 'Firefox OS'], 'VERSION'],

		#ruby-openid/2.1.8 (i686-linux)
		#i686-linux, etc
		[ qr/(\w+)\-(linux)/i ],
		['VERSION', 'NAME'],

		# Console
		[
			qr/(nintendo|playstation)\s([wids3portablevu]+)/i,                    # Nintendo/Playstation

			# GNU/Linux based
			qr/(mint)[\/\s\(]?(\w+)*/i,                                           # Mint
			qr/(joli|[kxln]?ubuntu|debian|[open]*suse|gentoo|\barch|slackware|fedora|mandriva|centos|pclinuxos|redhat|zenwalk)[\/\s-]?([\w\.-]+)*/i,

			# Joli/Ubuntu/Debian/SUSE/Gentoo/Arch/Slackware
			# Fedora/Mandriva/CentOS/PCLinuxOS/RedHat/Zenwalk
			qr/(hurd|linux)\s?([\w\.]+)*/i,                                       # Hurd/Linux
			qr/(gnu)\s?([\w\.]+)*/i                                               # GNU
		],
		['NAME', 'VERSION'],

		[ qr/(cros)\s[\w]+\s([\w\.]+\w)/i ],                                      # Chromium OS
		[['NAME', 'Chromium OS'], 'VERSION'],

		# Solaris
		[ qr/(sunos)\s?([\w\.]+\d)*/i ],                                          # Solaris
		[['NAME', 'Solaris'], 'VERSION'],

		# BSD based
		[ qr/\s([frentopc-]{0,4}bsd|dragonfly)\s?([\w\.]+)*/i ],                   # FreeBSD/NetBSD/OpenBSD/PC-BSD/DragonFly
		['NAME', 'VERSION'],

		[ qr/(ip[honead]+)(?:.*os\s*([\w]+)*\slike\smac|;\sopera)/i ],             # iOS
		[['NAME', 'iOS'], 'VERSION'],

		[ qr/(ppc)\s(mac\sos\sx)/i ],                                             # PPC Mac OS X
		['VERSION', 'NAME'],

		[ qr/(mac\sos\sx)\s?([\w\s\.]+\w)*/i ],                                   # Mac OS
		['NAME', 'VERSION'],

		# Other
		[
			qr/(haiku)\s(\w+)/i,                                                  # Haiku
			qr/(aix)\s((\d)(?=\.|\)|\s)[\w\.]*)*/i,                               # AIX
			qr/(macintosh|mac(?=_powerpc)|plan\s9|minix|beos|os\/2|amigaos|morphos|risc\sos)/i,
			# Plan9/Minix/BeOS/OS2/AmigaOS/MorphOS/RISCOS
			qr/(unix)\s?([\w\.]+)*/i                                              # UNIX
		],
		['NAME', 'VERSION']
	];

	for(my $i = 0; $i<= @$regexes; $i+=2) {
		my $patterns = $regexes->[$i];
		my $key = $regexes->[$i+1];
		my $result = {NAME => 'unknown', VERSION => 'unknown'};
		foreach my $pattern (@$patterns) {
			my @matches;
			my $m = 0;
			if( @matches = $ua =~ $pattern ) {
				foreach my $keyEntry (@$key) {
					if (ref($keyEntry) eq 'ARRAY') {
						$result->{$keyEntry->[0]} = $keyEntry->[1];
					}
					else {
						$result->{$keyEntry} = $matches[$m++];
					}
				}
				return $result;
			}
		}
	}
	return {NAME => 'unknown', VERSION => 'unknown'};
}

1;
