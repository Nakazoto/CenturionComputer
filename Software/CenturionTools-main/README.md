# Centurion Tools

An assembler, linker and related tools for the Warrex Centurion CPU-6.

## Basic usage

````
as [-l listfile] [-o objfile] foo.s

ld -b -C addr foo.o -o foo
````

The Warrex elements of the tool chain are new and lightly tested. The core of
the tool chain is well established and used for many other targets including
the TMS9995 and 6800 C compiler kits.

## Status

This is an initial cut at an assembler for what we know of the Warrex
Centurion CPU6 processor. The register naming is believed to be right
except for the mystery top registers. The syntax is primarily taken from
the EE200 but additional more generic operations like LD AL,xx are permitted
as well as the official LDAB xx.

As with the EE200 the source is on the left, so XFRB AL,BL places AL into
BL, and SUB A,B subtracts A from B (and has the short form SAB).

It should pick the shortest forms for instructions when it can.

Address mode syntax

````
	LD A,nn			constant
	LD A,(nn)		address
	LD A,@(nn)		address, indirected
	LD A,(X)		register dereference
	LD A,-5(X)		register dereference with offset
	LD A,(-X)		register pre-decremeent
	LD A,(X+)		register post-increment
	LD A,12(-S)		register pre-decrement with offset
	LD A,4(S+)		register post-increment with offset
	LD A,(PC + 6)		jump to PC + 6
	LD A,@(PC + 6)		jump to (PC + 6)
````

The syntax is a bit ad-hoc and based upon the reverse engineering work. It
will change if documentation gives us more useful results. Note that jump
in particular is a bit incoherent because JUMP actually uses the address
generator and stores the generated address into PC. We map

	JMP xxxx
	JMP (xxxx)

to one or two levels of indirection appropriately but don't currently do so
for (PC + 6) which is literally 'on 6 places' so ought to be JUMP PC + 6.
This needs some kind of sanity applying once we have an actual instruction
set.

Not yet handled
* MMU ops
* All of the cases we want self extending and backwards jumps
* BRA label  (aka JUMP PC+n but self extending)

Instruction size is determined by the register references. There are no
memory to memory instructions so the size is always explicit.

## Credits

The core of the assembler is derived from code that is

Copyright © 1977-1995 by Robert Swartz.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software without
specific prior written permission.

This software is provided by the copyright holders and contributors "as is" and
any express or implied warranties, including, but not limited to, the implied
warranties of merchantability and fitness for a particular purpose are
disclaimed. In no event shall the copyright holder or contributors be liable for
any direct, indirect, incidental, special, exemplary, or consequential damages
(including, but not limited to, procurement of substitute goods or services;
loss of use, data, or profits; or business interruption) however caused and on
any theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use of this
software, even if advised of the possibility of such damage.
