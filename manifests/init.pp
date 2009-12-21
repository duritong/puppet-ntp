#
# ntp module
# ntp/manifests/init.pp - Classes for configuring NTP
#
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class ntp {
    case $kernel {
        linux: {
            case $operatingsystem {
                debian: { include ntp::debian }
                gentoo: { include ntp::gentoo }
                default: { include ntp::linux }
            }
        }
        openbsd: { include ntp::openbsd }
        default: { fail("no classes for this kernel yet defined!") }
    }    

    case $virtual {
        'xenu': { include ntp::xenu }
    }
}
