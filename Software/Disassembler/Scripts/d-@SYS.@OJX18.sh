#!/bin/sh
#
# Selector appears to be stored in OJX00 at 0x8236 and checked after entry to
# determine where to jump to execute.

./scripts/disassm.py platters/HWKRPL2/\@SYS/\@OJX18.bin -base 0x8000 -subs '0x82c4:next(x for x,val in enumerate(args) if val < 0x80) + 1;;0x84c4:3;;0x8562:2;;0x84e7:0;;0x82fd:0;;0x826b:0;;0x827e:0;;0x8341:0;;0x825f:0;;0x829e:0;;0x832d:2;;0x8ce3:2;;0x8288:0;;0x8d0a:4;;0x84d2:1;;0x83a1:0' $*

