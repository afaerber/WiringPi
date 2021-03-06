#
# Makefile:
#	wiringPi device - Wiring compatible library for the Raspberry Pi
#
#	Copyright (c) 2012-2015 Gordon Henderson
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

VERSION=$(shell cat ../VERSION)
DESTDIR?=
PREFIX?=/usr/local
INCLUDEDIR?=$(PREFIX)/include
LIBDIR?=$(PREFIX)/lib

LDCONFIG?=ldconfig

ifneq ($V,1)
Q ?= @
endif

STATIC=libwiringPiDev.a
DYNAMIC=libwiringPiDev.so.$(VERSION)

#DEBUG	= -g -O0
DEBUG	= -O2
CC	= gcc
INCLUDE	= -I.
DEFS	= -D_GNU_SOURCE
CFLAGS	= $(DEBUG) $(DEFS) -Wformat=2 -Wall -Winline $(INCLUDE) -pipe -fPIC

LIBS    =

###############################################################################

SRC	=	ds1302.c maxdetect.c  piNes.c		\
		gertboard.c piFace.c			\
		lcd128x64.c lcd.c			\
		scrollPhat.c				\
		piGlow.c

OBJ	=	$(SRC:.c=.o)

HEADERS	=	ds1302.h gertboard.h  lcd128x64.h  lcd.h  maxdetect.h piFace.h  piGlow.h  piNes.h\
		scrollPhat.h

all:		$(DYNAMIC)

static:		$(STATIC)

$(STATIC):	$(OBJ)
	@echo "[Link (Static)]"
	$Q ar rcs $(STATIC) $(OBJ)
	$Q ranlib $(STATIC)
#	$Q size   $(STATIC)

$(DYNAMIC):	$(OBJ)
	@echo "[Link (Dynamic)]"
	$Q $(CC) -shared -Wl,-soname,libwiringPiDev.so$(WIRINGPI_SONAME_SUFFIX) -o libwiringPiDev.so.$(VERSION) -lpthread $(OBJ)

libwiringPiDev.so:	$(DYNAMIC)
	ln -sf $(DYNAMIC) $@

.c.o:
	@echo [Compile] $<
	$Q $(CC) -c $(CFLAGS) $< -o $@

.PHONY:	clean
clean:
	@echo "[Clean]"
	$Q rm -f $(OBJ) $(OBJ_I2C) *~ core tags Makefile.bak libwiringPiDev.*

.PHONY:	tags
tags:	$(SRC)
	@echo [ctags]
	$Q ctags $(SRC)


.PHONY:	install
install:	$(DYNAMIC)
	@echo "[Install Headers]"
	$Q install -m 0755 -d						$(DESTDIR)$(INCLUDEDIR)
	$Q install -m 0644 $(HEADERS)					$(DESTDIR)$(INCLUDEDIR)
	@echo "[Install Dynamic Lib]"
	$Q install -m 0755 -d						$(DESTDIR)$(LIBDIR)
	$Q install -m 0755 libwiringPiDev.so.$(VERSION)			$(DESTDIR)$(LIBDIR)/libwiringPiDev.so.$(VERSION)
	$Q ln -sf libwiringPiDev.so.$(VERSION)				$(DESTDIR)$(LIBDIR)/libwiringPiDev.so
	$Q $(LDCONFIG)

.PHONY:	install-static
install-static:	$(STATIC)
	@echo "[Install Headers]"
	$Q install -m 0755 -d						$(DESTDIR)$(INCLUDEDIR)
	$Q install -m 0644 $(HEADERS)					$(DESTDIR)$(INCLUDEDIR)
	@echo "[Install Static Lib]"
	$Q install -m 0755 -d						$(DESTDIR)$(LIBDIR)
	$Q install -m 0755 libwiringPiDev.a				$(DESTDIR)$(LIBDIR)

.PHONY:	install-deb
install-deb:	$(DYNAMIC)
	$(MAKE) install DESTDIR=~/wiringPi/debian-template/wiringPi PREFIX=/usr LDCONFIG=:

.PHONY:	uninstall
uninstall:
	@echo "[UnInstall]"
	$Q cd $(DESTDIR)$(INCLUDEDIR)/ && rm -f $(HEADERS)
	$Q cd $(DESTDIR)$(LIBDIR)/     && rm -f libwiringPiDev.*
	$Q $(LDCONFIG)


.PHONY:	depend
depend:
	makedepend -Y $(SRC)

# DO NOT DELETE

ds1302.o: ds1302.h
maxdetect.o: maxdetect.h
piNes.o: piNes.h
gertboard.o: gertboard.h
piFace.o: piFace.h
lcd128x64.o: font.h lcd128x64.h
lcd.o: lcd.h
scrollPhat.o: scrollPhatFont.h scrollPhat.h
piGlow.o: piGlow.h
