#!/usr/bin/env python3

import sys

if len(sys.argv) < 2:
    print("Usage: {} <filename> [<filename> ...]".format(sys.argv[0]))
    exit(1)

all_pass = True

for filename in sys.argv[1:]:
    with open(filename, "rb") as f:
        bytes = f.read()

    # find last non-null byte
    for end in range(len(bytes) - 1, -1, -1):
        if bytes[end] != 0:
            break

    expected = bytes[end]

    print(f"{filename} has {end:#05x} bytes of data")

    sum = 0
    for i in range(0, end, 1):
        byte = bytes[i]
        sum = (sum + byte) & 0xff

    if sum == expected:
        print("PASS: Checksum matches. ", end="")
    else:
        print("FAIL: Checksum does not match. ", end="")
        all_pass = False
    print(f"Expected: {expected:02x}, Result: {sum:02x}\n")

exit(0 if all_pass else 1)