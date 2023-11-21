#!/bin/sh
#
# 0x8b6a is the location of the SVC call to load a JX module.
#
# Command selector OJX#:
#
# FSPEC    0 02
# DSPEC    1 02
# STA      0 03
# START    1 04
# STOP     2 04
# LOG      3 04
# NOLOG    4 04
# PRI      5 04
# TIME     6 04
# NOTIME   7 04
# DUMP     8 04
# NODUMP   9 04
# MULTP   10 04
# RUN      0 05
# USE      0 06
# IOA      0 07
# CANCEL   0 09
# NEW      0 10
# FORMAT   0 11
# END      0 12
# DIR      0 13
# DEL      0 14
# REL      0 16
# CODE     1 16
# SETA     0 17
# SETC     1 17
# SKIP     0 18
# SKIPR    1 18
# JOB      0 19
# PARM     1 19
# NAM      0 21
# CLR      0 22
# VOL      0 23
# VSPEC    1 23
# PAUSE    0 24
# ENTER    1 24
# GUARD    2 24
# NOGUARD  3 24
# REORG    0 25
# BACKUP   1 25
# RESTORE  2 25
# COMPRESS 3 25
# EXPAND   4 25
# LOAD     0 26
# WIPLT    0 27
# REWIND   0 47
# WEOT     1 47
# RSKIP    2 47
#
# 50 and 51 are FDIPL and HDIPL respectively and are just data files for use by
# WIPLT 27.

./scripts/disassm.py platters/HWKRPL2/\@SYS/\@OJX00.bin -base 0x8000 -force "0x808e 0x8d2f" -jsrs "0x8d87:30" -subs '0x82c4:args.index(1) + 1;;0x8b36:2;;0x82ea:2;;0x8288:0;;0x8341:0' $*

