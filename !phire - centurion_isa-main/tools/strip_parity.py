#!/usr/bin/env python3

import sys
import struct

with open(sys.argv[1], "rb") as f:
    bytes = f.read()


with open(sys.argv[2], "wb") as f:
    for byte in bytes:
        f.write((byte & 0x7f).to_bytes(1, byteorder="big"))
