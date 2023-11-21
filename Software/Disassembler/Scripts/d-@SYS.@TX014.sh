#!/bin/sh

./scripts/disassm.py platters/HWKRPL2/\@SYS/\@TX014.bin -base 0x8000 -subs '0x81b3:1;;0x82a7:0' $*

