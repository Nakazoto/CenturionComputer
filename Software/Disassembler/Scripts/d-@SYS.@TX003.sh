#!/bin/sh

./scripts/disassm.py platters/HWKRPL2/\@SYS/\@TX003.bin -base 0x8000 -subs '0x810b:1' $*

