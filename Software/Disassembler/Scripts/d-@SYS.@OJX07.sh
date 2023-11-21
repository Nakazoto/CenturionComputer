#!/bin/sh

./scripts/disassm.py platters/HWKRPL2/\@SYS/\@OJX07.bin -base 0x8000 -subs '0x82c4:next(x for x,val in enumerate(args) if val < 0x80) + 1;;0x84c4:3;;0x8562:2;;0x84e7:0;;0x82fd:0' $*

