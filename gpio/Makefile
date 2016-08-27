#
# Makefile:
#	The gpio command:
#	  A swiss-army knife of GPIO shenanigans.
#	https://projects.drogon.net/wiring-pi
#
#	Copyright (c) 2012-2015 Gordon Henderson
#################################################################################
# This file is part of wiringPi:
#	Wiring compatible library for the Raspberry Pi
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

DESTDIR?=
PREFIX?=/usr/local
BINDIR?=$(PREFIX)/bin
INCLUDEDIR?=$(PREFIX)/include
LIBDIR?=$(PREFIX)/lib
MANDIR?=$(PREFIX)/man

ifneq ($V,1)
Q ?= @
endif

#DEBUG	= -g -O0
DEBUG	= -O2
CC	= gcc
INCLUDE	= -I$(DESTDIR)$(INCLUDEDIR)
CFLAGS	= $(DEBUG) -Wall $(INCLUDE) -Winline -pipe

LDFLAGS	= -L$(DESTDIR)$(LIBDIR)
LIBS    = -lwiringPi -lwiringPiDev -lpthread

# May not need to  alter anything below this line
###############################################################################

SRC	=	gpio.c readall.c pins.c

OBJ	=	$(SRC:.c=.o)

all:		gpio

version.h:	../VERSION
	@echo Need to run newVersion above.

gpio:	$(OBJ)
	@echo [Link]
	$Q $(CC) -o $@ $(OBJ) $(LDFLAGS) $(LIBS)

.c.o:
	@echo [Compile] $<
	$Q $(CC) -c $(CFLAGS) $< -o $@

.PHONY:	clean
clean:
	@echo "[Clean]"
	$Q rm -f $(OBJ) gpio *~ core tags *.bak

.PHONY:	tags
tags:	$(SRC)
	@echo [ctags]
	$Q ctags $(SRC)

.PHONY:	install
install: gpio
	@echo "[Install]"
	$Q mkdir -p		$(DESTDIR)$(BINDIR)
	$Q cp gpio		$(DESTDIR)$(BINDIR)
ifneq ($(WIRINGPI_SUID),0)
	$Q chown root.root	$(DESTDIR)$(BINDIR)/gpio
	$Q chmod 4755		$(DESTDIR)$(BINDIR)/gpio
endif
ifneq ($(WIRINGPI_INSTALL_MAN),0)
	$Q mkdir -p		$(DESTDIR)$(MANDIR)/man1
	$Q cp gpio.1		$(DESTDIR)$(MANDIR)/man1
endif

.PHONY:	install-deb
install-deb:	gpio
	$(MAKE) install DESTDIR=~/wiringPi/debian-template/wiringPi PREFIX=/usr WIRINGPI_SUID=0 WIRINGPI_INSTALL_MAN=0

.PHONY:	uninstall
uninstall:
	@echo "[UnInstall]"
	$Q rm -f $(DESTDIR)$(BINDIR)/gpio
	$Q rm -f $(DESTDIR)$(MANDIR)/man1/gpio.1

.PHONY:	depend
depend:
	makedepend -Y $(SRC)

# DO NOT DELETE

gpio.o: version.h
