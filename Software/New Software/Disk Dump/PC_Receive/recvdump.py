#!/usr/bin/python3
# rev 1.3, 2023 by Meisaka Yukara
# script to receive dumps from the Centurion via the xmit programs
# simple use: python recvdump.py <port> <dumpfile>
# option -h gives help (also readable below)
import sys
from pathlib import Path
import argparse
import struct
try: import serial
except:
	print(
'''pySerial must be installed, run
    pip3 install pyserial''', file=sys.stderr)
	exit(1)

DEFAULT_PORT = 'COM1' if sys.platform == 'win32' else '/dev/ttyS0'

argp = argparse.ArgumentParser(
	description='Receive dumps from Centurion over a serial port',
	formatter_class=argparse.RawTextHelpFormatter)
argp.add_argument('port', default=DEFAULT_PORT,
	help='the serial port to use, example: '+ DEFAULT_PORT)
argp.add_argument('file', nargs='?',
	help='file to save dump to')
argp.add_argument(
	'-m', action='store_true',
	help='remap the sectors into the output instead of a raw dump')
argp.add_argument(
	'--kind', default='auto', choices=['auto','hawk','finch'],
	help='what kind of dump to receive, default: %(default)s')
argp.add_argument(
	'--baud', default=19200, type=int,
	help='change the baud rate, default %(default)s')

def crc_init(poly = 0x1021):
	crct = [0 for x in range(256)]
	for i in range(256):
		v = i << 8
		for x in range(8): v = (v<<1) ^ (poly if (v&0x8000)!=0 else 0)
		crct[i] = v & 0xffff
	return crct
def crc_add(crc, v, t):
	return ((crc << 8) ^ t[((crc >> 8) ^ v) & 0xff]) & 0xffff

CCITT_BE = crc_init()
DISK_KINDS = {
	# name: (marker, sector info format, info len, (limits*), (image offsets))
	'hawk':  (b'HawkDump\r\n', '>H', 2, (12992,), (400,)),
	'finch': (b'FinchDump\r\n', '>HBB', 4, (605, 4, 29), (11600, 7018000, 400))
}
MIN_MARKER = 10

options = argp.parse_args()
port_baud = int(options.baud)
disk_kind = options.kind.lower()
kind = DISK_KINDS.get(disk_kind, None)
sector_dump_len = 420 # will be auto reduced if kind is set
if options.file is not None:
	file_path = Path(options.file)
	if not file_path.exists(): file_path.touch()
	file = file_path.open('+rb')
else: file = None
stat_file_written = 0

def write_sector(offset, sector_data):
	global file, stat_file_written
	file.seek(offset)
	file.write(sector_data)
	if offset + 400 > stat_file_written:
		stat_file_written = offset + 400

def validate_sector(sector):
	global kind, disk_kind, sector_dump_len, stat_file_written
	if kind is not None:
		if not sector.startswith(kind[0]): raise EOFError('Bad marker')
	elif len(sector) >= MIN_MARKER and disk_kind == 'auto':
		for kind_id in DISK_KINDS:
			if sector.startswith(DISK_KINDS[kind_id][0]):
				disk_kind = kind_id
				print('disk kind is', disk_kind, file=sys.stderr)
		if disk_kind == 'auto': EOFError('Bad marker')
		kind = DISK_KINDS[kind_id]
	sector_dump_len = len(kind[0]) + 404 + kind[2]
	# must end in a CRLF
	if sector[-2:] != b'\r\n': EOFError('Bad marker')
	# skip over the marker now that we checked it
	offset = len(kind[0])
	# parse the sector/track info
	info = struct.unpack(kind[1], sector[offset:offset+kind[2]])
	offset += kind[2]
	limits = kind[3]
	output_offsets = kind[4]
	disk_offset = 0
	# make sure it's in range
	for field in range(len(limits)):
		if info[field] >= limits[field]: raise IndexError('Bad track/sector index')
		disk_offset += info[field] * output_offsets[field]
	# calculate the CRC of the sector
	crc = 0
	for x in range(offset, min(len(sector), offset+402)):
		crc = crc_add(crc, sector[x], CCITT_BE)
	if crc != 0: raise ValueError('Bad CRC')
	if file is not None:
		if options.m: write_sector(disk_offset, sector[offset:offset+400])
		else:
			file.write(sector)
			stat_file_written += 400

stat_sector_count = 0
stat_resend_count = 0
stat_last_count = 0
show_waiting = True
def message():
	global stat_last_count
	if stat_last_count > 0: print(file=sys.stderr)
	stat_last_count = 0
def progress(char):
	global stat_last_count
	print(char, end='', flush=True, file=sys.stderr)
	stat_last_count += 1
	if stat_last_count >= 74:
		print(file=sys.stderr)
		stat_last_count = 0

try:
	with serial.Serial(
			port=options.port, baudrate=port_baud,
			bytesize=8, parity=serial.PARITY_NONE, stopbits=1
			) as port:
		print('receiving on', options.port, 'press CTRL-C to end.', file=sys.stderr)
		port.rts = True
		port.timeout = 1
		send_ok = True
		sector = bytearray()
		while True:
			sector.clear()
			port.timeout = 1
			while len(sector) == 0:
				port.write(b'\xff' if send_ok else b'\x00')
				try: byte_read = port.read()
				except serial.SerialException: byte_read = b''
				sector += byte_read
				if len(sector) == 0 and show_waiting:
					message()
					print('waiting...', end='', file=sys.stderr)
					show_waiting = False
			send_ok = True
			port.timeout = 0.03125
			while len(sector) < sector_dump_len:
				try: byte_read = port.read()
				except serial.SerialException:
					byte_read = b''
					send_ok = False
				if byte_read == b'': break
				sector += byte_read
			if not send_ok:
				progress('#')
				continue
			try:
				validate_sector(sector)
				stat_sector_count += 1
				progress('.')
			except:
				stat_resend_count += 1
				send_ok = False
				if isinstance(sys.exc_info()[1], EOFError): progress('!')
				else:
					message()
					print(sys.exc_info()[1], file=sys.stderr)

except KeyboardInterrupt:
	if file is not None: file.close()
	if stat_file_written > 0:
		print('wrote:', stat_file_written, 'bytes', file=sys.stderr)
	print('received:', stat_sector_count, 'sectors', file=sys.stderr)
	print('retransmits:', stat_resend_count, file=sys.stderr)
	exit(0)
except:
	print('error openning port:\n', sys.exc_info()[1], file=sys.stderr)
	exit(1)
"""
Copyright (c) 2023 Meisaka Yukara

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
"""
