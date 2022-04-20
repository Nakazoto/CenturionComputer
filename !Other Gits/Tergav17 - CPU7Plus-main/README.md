# CPU7Plus
A GUI-based emulator for the Centurion-series minicomputer

Right now this is very much a WIP, the basic framework for the processor register viewer / CPU control buttons are there, but that is about it. The actual CPU emulation is extremely barebones (it can only really execute jump instructions right now).

The memory editor and viewer are more or less fully functional. Hex information and be types directly into memory, which will update in real time regardless of CPU state. There is also a binary loader which can be used to load binary files directly into memory.
