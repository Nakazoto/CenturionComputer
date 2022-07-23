#
#	Build centurion version of the tools
#
all: ldwrx6 nmwrx6 osizewrx6 dumprelocswrx6

HDR = ld.h obj.h

CFLAGS = -DTARGET_WARREX -DOBJ_LONGNAME -Wall -pedantic -I../ld

ldwrx6: $(HDR) ld.o
	cc -o ldwrx6 ld.o

nmwrx6: $(HDR) nm.o
	cc -o nmwrx6 nm.o

osizewrx6: $(HDR) osize.o
	cc -o osizewrx6 osize.o

dumprelocswrx6: $(HDR) dumprelocs.o
	cc -o dumprelocswrx6 dumprelocs.o

clean:
	rm -f *.o *~
	rm -f nmwrx6 osizewrx6 dumprelocswrx6

install:
	mkdir -p /opt/aswrx6/bin
	cp ldwrx6 nmwrx6 osizewrx6 dumprelocswrx6 /opt/aswrx6/bin/
