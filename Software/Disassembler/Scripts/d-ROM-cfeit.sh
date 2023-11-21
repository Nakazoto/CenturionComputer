#!/bin/sh

./scripts/disassm.py images/BPNCFEIT-reordered.BIN -rom -base 0xfc00 -entry 0x100 -force "0xfd0f" -subs '0xfd81:args.index(0) + 1;;0xfd92:0;;0xfda9:1' $*

