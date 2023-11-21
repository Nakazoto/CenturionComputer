#!/bin/sh
#
# ROM#2 (0x8800):
#   0x8849: CPU INSTRUCTION TEST
#   0x8dbb: CPU-6 MAPPING RAM TEST
#   0x8f5f: ROM SELF TEST
#
# Note: there is no actual entrypoint, but the disassembler requires one.

./scripts/disassm.py images/Diag_F2_Rev_1.0.BIN -rom -base 0x8800 -entry 0x075f -force "0x8849 0x8dbb 0x8f5f 0x8ed9" -subs '0x8fcc:args.index(0) + 1;;0x8e75:1;;0x8ea7:0;;0x8ecc:0' -jsrs '0x884e:45 0x8dc0:47 0x8dfa:44 0x8e34:0 0x8f36:26' $*

