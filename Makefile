# dzen
#   (C)opyright MMVII Robert Manea

include config.mk

SRC = draw.c main.c util.c action.c
OBJ = ${SRC:.c=.o}

all: options dzen

options:
	@echo dzen build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"
	@echo "LD       = ${LD}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: dzen.h action.h config.mk

dzen: ${OBJ}
	@echo LD $@
	@${LD} -o $@ ${OBJ} ${LDFLAGS}
	@strip $@
	@echo "Run ./help for documentation"

clean:
	@echo cleaning
	@rm -f dzen ${OBJ} dzen-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p dzen-${VERSION}
	@mkdir -p dzen-${VERSION}/gadgets
	@mkdir -p dzen-${VERSION}/bitmaps
	@cp -R CREDITS LICENSE Makefile INSTALL README.dzen README help config.mk action.h dzen.h ${SRC} dzen-${VERSION}
	@cp -R gadgets/Makefile  gadgets/config.mk gadgets/README.dbar gadgets/textwidth.c gadgets/README.textwidth gadgets/dbar.c gadgets/gdbar.c gadgets/README.gdbar gadgets/gcpubar.c gadgets/README.gcpubar gadgets/kittscanner.sh gadgets/README.kittscanner gadgets/noisyalert.sh dzen-${VERSION}/gadgets
	@cp -R bitmaps/alert.xbm bitmaps/ball.xbm bitmaps/battery.xbm bitmaps/envelope.xbm bitmaps/volume.xbm bitmaps/pause.xbm bitmaps/play.xbm bitmaps/music.xbm  dzen-${VERSION}/bitmaps
	@tar -cf dzen-${VERSION}.tar dzen-${VERSION}
	@gzip dzen-${VERSION}.tar
	@rm -rf dzen-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f dzen ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/dzen

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/dzen

.PHONY: all options clean dist install uninstall
