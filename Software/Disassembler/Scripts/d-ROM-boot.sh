#!/bin/sh

./scripts/disassm.py images/BPN6-reordered.BIN -rom -base 0xfc00 -entry 0x100 -force "0xfcfe 0xfdb1" -jsrs "0xfdb5:2 0xfdbe:0" -subs '0xfc92:args.index(0) + 1;;0xfc8e:1;;0xfd2f:0;;0xfd9e:0' $*

