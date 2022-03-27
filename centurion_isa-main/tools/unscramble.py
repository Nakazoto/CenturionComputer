#!/usr/bin/env python3

import sys
import struct

with open(sys.argv[1], "rb") as f:
    bytes = f.read()

with open(sys.argv[2], "wb") as f:
    print(len(bytes))
    for i in range(len(bytes)):
        # A0 through A4 seem fine
        addr = i & 0b0_0001_1111

        a5 = (i >> 5) & 1
        a6 = (i >> 6) & 1
        a7 = (i >> 7) & 1
        a8 = (i >> 8) & 1

        addr |= (a8 << 5) | (a5 << 6)
        addr |= (a6 << 7) | (a7 << 8)





        f.write(bytes[addr].to_bytes(1, byteorder="big"))