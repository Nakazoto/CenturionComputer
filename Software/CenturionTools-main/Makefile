.PHONY:	aswrx6 ldwrx ccom copt

all: 	ccwrx6 aswrx6 ldwrx6 ccom copt crt0.o libc.a libwrx6.a

aswrx6:
	(cd as; make)

ldwrx6:
	(cd ld; make)

ccom:
	(cd common; make)
	(cd ccom; make)

copt:
	(cd copt; make)

install:
	mkdir -p /opt/aswrx6/bin
	mkdir -p /opt/aswrx6/include
	mkdir -p /opt/aswrx6/lib
	(cd as; make install)
	(cd ld; make install)
	cp ccwrx6 /opt/aswrx6/bin/
	cp -r include/* /opt/aswrx6/include/
	cp ccom/ccwrx /opt/aswrx6/lib/ccwrx
	cp copt/copt /opt/aswrx6/lib/copt
	cp ccwrx.rules /opt/aswrx6/lib/
	cp crt0.o /opt/aswrx6/lib/
	cp libc.a /opt/aswrx6/lib/
	cp libwrx6.a /opt/aswrx6/lib/

ccwrx6: ccwrx6.c
	gcc -Wall -pedantic -O2 ccwrx6.c -o ccwrx6


# Members for the C library
COBJ =	libc/memcpy.o \
	libc/memset.o \
	libc/strlen.o \
	libc/abort.o \
	libc/abs.o \
	libc/atoi.o \
	libc/atol.o \
	libc/bcmp.o \
	libc/bcopy.o \
	libc/bsearch.o \
	libc/bzero.o \
	libc/calloc.o \
	libc/crypt.o \
	libc/exit.o \
	libc/free.o \
	libc/getopt.o \
	libc/index.o \
	libc/isalnum.o \
	libc/isalpha.o \
	libc/isascii.o \
	libc/isblank.o \
	libc/iscntrl.o \
	libc/isdigit.o \
	libc/isgraph.o \
	libc/islower.o \
	libc/isprint.o \
	libc/ispunct.o \
	libc/isspace.o \
	libc/isupper.o \
	libc/isxdigit.o \
	libc/libintl.o \
	libc/lrand48.o \
	libc/lsearch.o \
	libc/ltoa.o \
	libc/ltostr.o \
	libc/malloc.o \
	libc/memccpy.o \
	libc/memcmp.o \
	libc/memmove.o \
	libc/qsort.o \
	libc/realloc.o \
	libc/rindex.o \
	libc/strcasecmp.o \
	libc/strcasestr.o \
	libc/strcat.o \
	libc/strchr.o \
	libc/strcmp.o \
	libc/strcoll.o \
	libc/strcpy.o \
	libc/strcspn.o \
	libc/strdup.o \
	libc/stricmp.o \
	libc/strlcpy.o \
	libc/strncasecmp.o \
	libc/strncat.o \
	libc/strncmp.o \
	libc/strncpy.o \
	libc/strnicmp.o \
	libc/strnlen.o \
	libc/strpbrk.o \
	libc/strrchr.o \
	libc/strsep.o \
	libc/strspn.o \
	libc/strstr.o \
	libc/strtok.o \
	libc/strtok_r.o \
	libc/strtol.o \
	libc/strxfrm.o \
	libc/swab.o \
	libc/tfind.o \
	libc/tolower.o \
	libc/toupper.o \
	libc/xitoa.o

STDIO =	stdio/fclose.o \
	stdio/fflush.o \
	stdio/fgetc.o \
	stdio/fgetpos.o \
	stdio/fgets.o \
	stdio/fopen.o \
	stdio/fprintf.o \
	stdio/fputc.o \
	stdio/fputs.o \
	stdio/fread.o \
	stdio/fscanf.o \
	stdio/fsetpos.o \
	stdio/ftell.o \
	stdio/fwrite.o \
	stdio/gets.o \
	stdio/getw.o \
	stdio/printf.o \
	stdio/putchar.o \
	stdio/putw.o \
	stdio/sprintf.o \
	stdio/sscanf.o \
	stdio/stdio0.o \
	stdio/vfprintf.o \
	stdio/vfscanf.o \
	stdio/vprintf.o \
	stdio/vscanf.o \
	stdio/vsscanf.o

SUPPORT = \
	supportwrx6/asreax4.o \
	supportwrx6/asreax8.o \
	supportwrx6/bneg.o \
	supportwrx6/center.o \
	supportwrx6/cexit.o \
	supportwrx6/compleax.o \
	supportwrx6/__cpu_to_le16.o \
	supportwrx6/__cpu_to_le32.o \
	supportwrx6/divide32x32.o \
	supportwrx6/divide.o \
	supportwrx6/laddeq.o \
	supportwrx6/lbneg.o \
	supportwrx6/lsubeq.o \
	supportwrx6/makebool.o \
	supportwrx6/multiply32x32.o \
	supportwrx6/negeax.o \
	supportwrx6/shleax.o \
	supportwrx6/shr.o \
	supportwrx6/shreax8.o \
	supportwrx6/shreax4.o \
	supportwrx6/tmp.o \
	supportwrx6/tosasleax.o \
	supportwrx6/tosasrax.o \
	supportwrx6/tosasreax.o \
	supportwrx6/tosdivax.o \
	supportwrx6/tosdiveax.o \
	supportwrx6/tosmodeax.o \
	supportwrx6/tosshlax.o \
	supportwrx6/tosshrax.o \
	supportwrx6/tosudivax.o \
	supportwrx6/tosudiveax.o \
	supportwrx6/tosumodeax.o \
	supportwrx6/tosumulax.o

crt0.o: as/aswrx6 crt0.s
	as/aswrx6 crt0.s

libc.a:	ccwrx6 $(STDIO) $(COBJ)
	ar rc libc.a $(STDIO) $(COBJ) $(AOBJ)

libwrx6.a: ccwrx6 $(SUPPORT)
	ar rc libwrx6.a $(SUPPORT)

%.o: %.c
	./ccwrx6 -Iinclude -c $^

%.o: %.s
	as/aswrx6 $^

clean:
	(cd as; make clean)
	(cd ld; make clean)
	(cd common; make clean)
	(cd ccom; make clean)
	rm -f $(COBJ) $(STDIO) $(SUPPORT)
	rm -f *~ */*~
