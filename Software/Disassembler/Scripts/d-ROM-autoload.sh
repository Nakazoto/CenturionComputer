#!/bin/sh

./scripts/disassm.py images/AUTOLOAD.BIN -rom -base 0xef00 -force "" -jsrs "0xefd1:0 0xefd5:0 0xefd9:0 0xefdf:0 0xefe5:0" -subs '0xef2a:0' $*

