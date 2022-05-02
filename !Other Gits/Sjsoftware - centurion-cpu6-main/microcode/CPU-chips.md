# CPU Part Function

Incomplete

* A1 74LS74 - Dual D Flip Flop Bus timing/control?
* A2 7438 - Bus driver open collector for wired OR signals
* A3 74LS04 - Inverter
* A4 DS8835 - Bus transceiver for address bus
* A5 DS8835 - Bus transceiver for address bus
* A6 DS8835 - Bus transceiver for address bus
* A7 74LS240 - Bus transceiver for PC (highest nibble) combines with A6 / signals from front panel (?) combines with half of dip switches M7
* A8 DS8835 - Bus transceiver for address bus
* A9 DS8835 - Bus transceiver for address bus
* A10 DS8835 - Bus transceiver for address bus
* A11 AM2907 - Bus transceiver for data bus
* A12 AM2907 - Bus transceiver for data bus
* A13 7437 - Bus driver Parity bit and ??
* A14 7438 - Bis driver open collector for wired OR signals
* A15 74LS04 - Inverter
* B1 to B6 - Memory Address Register and Memory Work Register (PC and X)
* B7 74LS30 - 8 input NAND gate (possibly address comparator)
* B8 74LS30 - 8 input NAND gate (possibly address comparator)
* B9 93L422 - 4 bit memory Page Table
* B10 93L422 - 4 bit memory Page Table
* B11 74LS10 - 3 input NAND gate
* B12 74LS00 - NAND gate
* B13 6309 - 8 bit PROM - instruction decoding?
* B15 74LS74 - Dual D Flip Flop Bus timing/control?
* C1 to C6 - Memory Address Register and Memory Work Register
* C7 74LS02 - NOR gate
* C8 74LS04 - Inverter
* C9 74LS377 - Octal D Flip Flop Data Register for page table and register file?
* C10 74LS04 - Inverter
* C11 74LS173 - Quad D Flip Flop tristate outputs - instruction decoding?
* C12 74LS173 - Quad D Flip Flop tristate outputs - instruction decoding?
* C13 74LS377 - Octal D Flip Flop for Register Index Register
* C14 74LS157 - Quad 2 to 1 multiplexer for interrupt level selection?
* C15 74LS669 - 4 bit counter for interrupt level register?
* D1 socket for sequencer address injection/monitoring
* D2 74LS139 - 1 of 4 decoder used for internal bus transmitters? (only half used)
* D3 74LS138 - 1 of 8 decoder used for internal bus transmitters?
* D4 74LS174 - Hex D Flip Flop D2/D3 latching
* D5 74LS174 - Hex D Flip Flop D2/D3 latching
* D6 74LS157 - Quad 2 to 1 multiplexer for MAR/MWR clock/inc/dec control
* D7 74120 - Clock Synchonizer CPU clock control?
* D8 74LS20 - 4 input NAND gate
* D9 74LS378 - Hex D Flip Flop - some machine register? Possibly page index for address bus
* D10 74LS02 - NOR gate
* D11 74LS378 - Hex D Flip Flop - Page Table Base Register
* D12 74LS00 - NAND gate
* D13 74LS374 - Octal D Flip Flop tristate outputs - Register Contents Register
* D14 93L422 - 4 bit memory Registers
* D15 93L422 - 4 bit memory Registers
* E6 74LS138 - 1 of 8 decoder controlling reads from the bus?
* E7 74LS138 - 1 of 8 decoder controlling reads from the bus?
* E8 74LS02 - NOR gate - seems to be largely clock control?
* E9 P4 socket for F bus monitoring/injection
* E10 74LS10 - 3 input NAND gate
* E11 74LS10 - 3 input NAND gate
* E12 74LS04 - Inverter
* E14 74LS74 - Dual D Flip Flop - data bus cycle timing?
* E15 74LS74 - Dual D Flip Flop - data bus cycle timing?
* F6 74LS153 - Dual 4 to 1 multiplexer - Carry control on 16 bit arithmetic?
* F7/8 AM2901 - ALU - high nibble
* F9/10 AM2901 - ALU - low nibble
* F11 74LS259 - Addressable Latch - CPU state control?
* F12 74LS74 - Dual D Flip Flop - ?? Clock?
* F13 74LS174 - Hex D Flip Flop - Sequencer conditional register (feeds K13)
* F14 74LS00 - NAND gate
* F15 P10 socket for DP monitoring/injection
* H6 74LS253 - Dual 4 to 1 multiplexer - Shift control
* H11 74LS138 - 1 of 8 decoder controlling reads from the bus/sequencer conditional?
* H12 74120 - Clock Synchonizer CPU clock control?
* H13 74LS20 - 4 input NAND gate
* H14 74LS368 - Hex Inverting Tristate - interrupt level onto bus?
* J6 74LS04 - Inverter - various ALU/Sequencer glue
* J7/8 AM2909 - 4 bit sequencer bits 4-7
* J9 74LS378 - Hex D Flip Flop Status Register from ALU
* J10 74LS151 - 8 to 1 multiplexer - sequencer conditional control?
* J11 74LS151 - 8 to 1 multiplexer - sequencer conditional control?
* J12 74LS153 - Dual 4 to 1 multiplexer sequencer conditional control?
* J13 74LS153 - Dual 4 to 1 multiplexer sequencer conditional control?
* K6 74LS00 - NAND gate - sequencer glue logic
* K9 74S151 - 8 to 1 multiplexer (fast) sequencer conditional control?
* K10 74LS00 - NAND gate
* K11 74LS138 - 1 of 8 decoder controlling reads from the bus/sequencer conditional?
* K12 74LS02 - NOR gate
* K13 74LS153 - Dual 4 to 1 multiplexer sequencer conditional control?
* L6 74LS00 NAND gate sequencer glue logic
* L7/8 AM2909 - 4 bit sequencer bits 0-3
* L9 AM2911 - 4 bit sequencer bits 8-11 (11 not used)
* L10 74LS74 - Dual D Flip Flop - Clock halver and ??
* L11 74LS157 - Quad 2 to 1 multiplexer selects between signals from P7 (L12) or L10 and others
* L12 P7 socket for clock monitoring/injection, sequencer output control
* L13 74LS109 - Dual JK Flip Flop
* L14 74LS00 - NAND gate
* M6 74LS240 - Octal transceiver inverting 3 state outputs - constant from microcode to bus
* M7 74LS240 - Octal transceiver inverting 3 state outputs - dip switches to bus
* M8 74LS240 - Octal transceiver inverting 3 state outputs - P2 I/O
* M9 74LS74 - Dual D Flip Flop - Clock control
* M10 7437 - Bus Driver - Clock driver and oscillator
* M12 74LS378 - Hex D Flip Flop unknown machine register
* M13 74LS259 - Addressable Latch - CPU state control?
* M14 74LS240 - Octal transceiver inverting 3 state outputs - P3 I/O
* M15 74LS240 - Octal transceiver inverting 3 state outputs - P3 I/O
* P5/P6 - microcode word monitoring/injection
