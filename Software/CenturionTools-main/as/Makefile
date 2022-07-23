#
#	Build centurion version of the tools
#
all: aswrx6

HDR = as.h ../ld/ld.h ../ld/obj.h

AOBJ = as0.o as1-centurion.o as2.o as3.o as4.o as6-centurion.o

CFLAGS = -DTARGET_WARREX -DOBJ_LONGNAME -Wall -pedantic -I../ld

aswrx6: $(HDR) $(AOBJ)
	cc -o aswrx6 $(AOBJ)

clean:
	rm -f *.o *~
	rm -f aswrx6

install:
	mkdir -p /opt/aswrx6/bin
	cp aswrx6 /opt/aswrx6/bin/
