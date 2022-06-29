aswrx6 -l listing_ccdp.txt ccdp.asm
ldwrx6 -b -C 28672 -o ccdp.raw ccdp.o
dd if=ccdp.raw bs=28672 skip=1 of=bin/CCDP.BIN
cat headers/32K.header bin/CCDP.BIN > bin/32K.SYS

ldwrx6 -b -C 15360 -o ccdp.raw ccdp.o
dd if=ccdp.raw bs=15360 skip=1 of=bin/CCDP.BIN
cat headers/16K.header bin/CCDP.BIN > bin/16K.SYS
rm ccdp.o ccdp.raw bin/CCDP.BIN

aswrx6 -l listing_hello.txt hello.asm
ldwrx6 -b -C 512 -o hello.raw hello.o
dd if=hello.raw bs=512 skip=1 of=bin/HELLO.BIN
rm hello.raw hello.o

aswrx6 -l listing_dir.txt dir.asm
ldwrx6 -b -C 512 -o dir.raw dir.o
dd if=dir.raw bs=512 skip=1 of=bin/DIR.BIN
rm dir.raw dir.o

aswrx6 -l listing_type.txt type.asm
ldwrx6 -b -C 512 -o type.raw type.o
dd if=type.raw bs=512 skip=1 of=bin/TYPE.BIN
rm type.raw type.o

aswrx6 -l listing_copy.txt copy.asm
ldwrx6 -b -C 512 -o copy.raw copy.o
dd if=copy.raw bs=512 skip=1 of=bin/COPY.BIN
rm copy.raw copy.o

aswrx6 -l listing_delete.txt delete.asm
ldwrx6 -b -C 512 -o delete.raw delete.o
dd if=delete.raw bs=512 skip=1 of=bin/DELETE.BIN
rm delete.raw delete.o

aswrx6 -l listing_boot.txt boot.asm
ldwrx6 -b -C 512 -o boot.raw boot.o
dd if=boot.raw bs=512 skip=1 of=bin/BOOT.BIN
rm boot.raw boot.o

aswrx6 -l listing_ffcmon.txt ffcmon.asm
ldwrx6 -b -C 512 -o ffcmon.raw ffcmon.o
dd if=ffcmon.raw bs=512 skip=1 of=bin/FFCMON.BIN
rm ffcmon.raw ffcmon.o

aswrx6 -l listing_hwkdmp.txt hwkdmp.asm
ldwrx6 -b -C 512 -o hwkdmp.raw hwkdmp.o
dd if=hwkdmp.raw bs=512 skip=1 of=bin/HWKDMP.BIN
rm hwkdmp.raw hwkdmp.o

aswrx6 -l listing_intprb.txt intprb.asm
ldwrx6 -b -C 512 -o intprb.raw intprb.o
dd if=intprb.raw bs=512 skip=1 of=bin/INTPRB.BIN
rm intprb.raw intprb.o


aswrx6 -l listing_bootstrap.txt bootstrap.asm
rm bootstrap.o

mv *.txt listings/
