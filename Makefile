#
# Makefile:
#	wiringPi - Wiring compatible library for the Raspberry Pi
#
#	Copyright (c) 2012-2015 Gordon Henderson
#	Copyright (c) 2016 Andreas Färber
#################################################################################
# This file is part of wiringPi:
#	https://projects.drogon.net/raspberry-pi/wiringpi/
#
#    wiringPi is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    wiringPi is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
#################################################################################

.PHONY: all static clean install install-static uninstall

all:
	$(MAKE) all -C wiringPi libwiringPi.so
	$(MAKE) all -C devLib libwiringPiDev.so INCLUDE='-I../wiringPi'
	$(MAKE) all -C gpio INCLUDE='-I../wiringPi -I../devLib' LDFLAGS='-L../wiringPi -L../devLib'

static:
	$(MAKE) static -C wiringPi
	$(MAKE) static -C devLib

clean:
	$(MAKE) clean -C wiringPi
	$(MAKE) clean -C devLib
	$(MAKE) clean -C gpio

install: all
	$(MAKE) install -C wiringPi
	$(MAKE) install -C devLib
	$(MAKE) install -C gpio

install-static: static
	$(MAKE) install-static -C wiringPi
	$(MAKE) install-static -C devLib
