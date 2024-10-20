#!/usr/bin/python3

from io import BufferedWriter
from pathlib import Path, PurePosixPath
import sys
import argparse
from datetime import date

parser = argparse.ArgumentParser(description='Scan Centurion disk images\nImage must be a raw image: 400 B/sect padded to 512 B/sect (CCDP compatible)',add_help=True)
parser.add_argument('-x', action='store_true', help='extract matching file')
parser.add_argument('-d', action='store_true', help='display matching file')
parser.add_argument('-t', action='store_true', help='convert text files')
parser.add_argument('file')
parser.add_argument('search_file', nargs='?')
inargs = parser.parse_args()

f = Path(inargs.file)
search = None
if inargs.search_file:
    search = PurePosixPath(inargs.search_file.upper())
    print(search)

fb = bytearray(f.read_bytes())

l = len(fb)
def clearhi(v):
    i = 0
    while i < len(v):
        if v[i] < 0x80:
            return False
        v[i] &= 0x7f
        i += 1
    return True

def entstr(bv):
    v = bytearray(bv)
    if not clearhi(v):
        print('invalid entry string')
        exit()
    return str(v, 'ascii').rstrip()

FILETYPES = {0x00:'DIR',0x01:'BIN',0x02:'TXT',0x03:'CTG',0x04:'EXF',0x05:'LIB',0x06:'IND',0x07:'SEG',0x08:'QUE'}

def filetype(ft:int):
    ft = ft & 0x0F
    return FILETYPES.get(ft, hex(ft))

def extract_text(outfile:BufferedWriter, sector_list:list):
    for x in sector_list:
        fcvb = bytearray(fb[x*0x200:x*0x200 + 400])
        clearhi(fcvb)
        y = 0
        yl = False
        while y < len(fcvb):
            if fcvb[y] == 0xd:
                if yl:
                    fcvb = fcvb[0:y]
                    break
                fcvb[y] = 10
                yl = True
            elif fcvb[y] == 0:
                yl = False
                del fcvb[y]
                continue
            else:
                yl = False
            y += 1
        outfile.write(fcvb)
    pass
def extract_bin(outfile:BufferedWriter, sector_list:list):
    vofs = 0
    for x in sector_list:
        fcvb = bytearray(fb[x*0x200:x*0x200 + 400])
        ofs = 0
        while ofs < len(fcvb):
            rectype = fcvb[ofs]
            if rectype > 1:
                break
            reclen = fcvb[ofs+1]
            recbase = fcvb[ofs+2:ofs+4]
            slbuf = fcvb[ofs+4:ofs+4+reclen]
            recsum = rectype + reclen + recbase[0] + recbase[1] + fcvb[ofs + reclen + 4]
            for i in range(reclen):
                recsum += slbuf[i]
                slbuf[i] &= 0x7f
                if slbuf[i] < 9 or slbuf[i] == 11 or slbuf[i] == 12 or slbuf[i] == 127 or (slbuf[i] > 13 and slbuf[i] < 32):
                    slbuf[i] = 0x2e
            #vofs = recbase
            #print(recbase.hex(),rectype,(recsum & 0xff) == 0,':', fcvb[ofs+4:ofs+4+reclen].hex(' '), repr(bytes(slbuf)))
  #          if rectype == 0:
  #              print(recbase.hex(),':', repr(bytes(slbuf)))
            ofs += 5+reclen
        outfile.write(fcvb)
    pass
def extract_raw(outfile:BufferedWriter, sector_list:list):
    for x in sector_list:
        fcvb = bytearray(fb[x*0x200:x*0x200 + 400])
        outfile.write(fcvb)
    pass
def filelist(start:int, use_offset=False, base=''):
    
    sec = start * 0x200
    volname = fb[sec:sec+0x0a]
    volmap = fb[sec+0xe:sec+0x10]
    mapsec = int.from_bytes(volmap, 'big') * 0x200
    volnamestr = base + entstr(volname)
    if use_offset:
        mapsec += sec
    else:
        print('volume label:',volnamestr)

    # print(start.to_bytes(2,'big').hex(),':',sec.to_bytes(4,'big').hex(),' ',
    #     repr(volnamestr),' ',volmap.hex(),
    #     sep='')
    entofs = 0x10
    ind = 0
    while ind < 100:
        while entofs < 400:
            ent = sec + entofs
            fname = fb[ent:ent+0x0a]
            if fname[0] == 0:
                entofs += 0x10
                continue
            if fname[0] == 0x84 and fname[1] == 0x8D:
                return
            fmap = fb[ent+0x0a]
            fmapsec = int.from_bytes(fb[ent+0x0b:ent+0x0d], 'big') * 0x200
            fmapseci = fmapsec
            ftype = fb[ent+0x0d]
            fdatestamp = int.from_bytes(fb[ent+0x0e:ent+0x10], 'big')
            # date stamp, days since 1900 ?
            fdate = date.fromordinal(693594 + fdatestamp) # 1900 Jan 1 + days
            fdatef = ' <NOT SET>'
            if fdatestamp > 0:
                fdatef = fdate.isoformat()
            fxs = mapsec + fmapseci + fmap * 3
            # length in sectors, minus 1
            # alternately: stop after this many sectors
            try:
                fxlen = int.from_bytes(fb[fxs:fxs+2], 'big')
                fxbuffer = fb[fxs+2:fxs+4]
                fxclshift = fb[fxs+4]
                fx2 = fb[fxs+5:fxs+6]
            except:
                print('invalid or corrupt image, if no data was listed: try arcscan.py')
                exit(1)
            fxsize = 1 << fxclshift
            if fxsize > 0x100000:
                print('invalid or corrupt image, if no data was listed: try arcscan.py')
                exit(1)
            fxs += 6
            msec = []
            msi = 0
            while msi < 155:
                mso = fxs + msi * 3
                if fb[mso] == 0xff:
                    if fb[mso+1] != 0xff:
                        fmapseci = (fb[mso+1] ^ 0xff) * 0x200
                        fxs = mapsec + fmapseci
                        msi = fb[mso+2]
                        continue
                    break
                msent = int.from_bytes(fb[mso+1:mso+3], 'big')
                if use_offset:
                    msent += start
                msec.append(msent)
                msi += 1
            fentstr = entstr(fname)
            fentfile = PurePosixPath(fentstr)
            if len(base) == 0:
                fentpath = fentstr
            else:
                fentpath = base + '.' + fentstr
            show = True
            match = False
            if search:
                show = False
                if search.is_absolute():
                    if fentpath == search:
                        print('MATCH PATH')
                        match = True
                elif fentfile == search:
                    print('MATCH FILE')
                    match = True
            try:
                msecfull = []
                for x in msec:
                    msecfull.extend(range(x, x+fxsize))
                if show or match:
                    print(start.to_bytes(2,'big').hex(),':',ent.to_bytes(4,'big').hex(),' -> ',
                        str(fentpath).ljust(16),':',filetype(ftype).ljust(3),':',fdatef,
                        ' (',(mapsec + fmapsec).to_bytes(4,'big').hex(),':',fmap.to_bytes(1,'big').hex(),
                        ')-> l:',fxlen.to_bytes(2,'big').hex(),' ',fxbuffer.hex().upper(),' cls:',fx2.hex().upper(),
                        ' sz:',(len(msec) * fxsize).to_bytes(2,'big').hex(),' '
                        ' ',hex(msec[0]) if len(msec) else '','=>',hex(msec[0]*0x200) if len(msec) else '',
                        '[',','.join([hex(x) for x in msecfull]),']',
                        sep='')
                if match:
                    print('[',','.join([hex(y) for y in msecfull]),']',)
                    if inargs.d:
                        if inargs.t and (ftype == 0x02 or ftype == 0x12 or ftype not in FILETYPES):
                            extract_text(sys.stdout.buffer, msecfull)
                        elif ftype == 0x04 or ftype == 0x14:
                            extract_bin(sys.stdout.buffer, msecfull)
                    elif inargs.x:
                        pathparts=fentpath.lstrip('.').split('.')
                        relpath=f.stem
                        for pp in pathparts:
                          Path(relpath).mkdir(exist_ok=True)
                          relpath = relpath + '/' + pp;
                        if inargs.t and (ftype == 0x02 or ftype == 0x12 or ftype not in FILETYPES):
                            outpath = Path(relpath + '.txt')
                            outfile = outpath.open('w+b')
                            extract_text(outfile, msecfull)
                        elif ftype == 0x04 or ftype == 0x14:
                            outpath = Path(relpath + '.bin')
                            outfile = outpath.open('w+b')
                            extract_bin(outfile, msecfull)
                        elif ftype == 0x05 or ftype == 0x15:
                            outpath = Path(relpath + '.lib')
                            outfile = outpath.open('w+b')
                            extract_raw(outfile, msecfull)
                        else:
                            outpath = Path(relpath + '.raw')
                            outfile = outpath.open('w+b')
                            extract_raw(outfile, msecfull)
                        outfile.close()
                        print('wrote', outpath)
                
                if (ftype == 0x05 or ftype == 0x15) and len(msec) > 0:
                    if use_offset:
                        filelist(msec[0], True, volnamestr + '.' + fentstr)
                    else:
                        filelist(msec[0], True, base + '.' + fentstr if base != "" else fentstr)
            except Exception as e:
                print('Error: ' + str(e))
            entofs += 0x10
        ind += 1
        entofs = 0
        sec += 0x200

filelist(0x10)

