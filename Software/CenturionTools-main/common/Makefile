HDRS = abend.h addrsize.h alignment.h assertion.h attrib.h bitops.h cddefs.h \
       chartype.h check.h cmdline.h coll.h cpu.h debugflag.h exprdefs.h \
       fileid.h filepos.h filestat.h filetime.h filetype.h fname.h fp.h \
       fragdefs.h gentype.h hashfunc.h hashtab.h hlldbgsym.h inline.h \
       intptrstack.h intstack.h inttypes.h libdefs.h lidefs.h matchpat.h \
       mmodel.h objdefs.h optdefs.h print.h scopedefs.h searchpath.h segdefs.h \
       segnames.h shift.h strbuf.h strpool.h strstack.h strutil.h symdefs.h \
       target.h va_copy.h version.h xmalloc.h xsprintf.h

OBJS = abend.o addrsize.o alignment.o assertion.o bitops.o chartype.o check.o \
       cmdline.o coll.o cpu.o debugflag.o exprdefs.o fileid.o filepos.o \
       filestat.o filetime.o filetype.o fname.o fp.o gentype.o hashfunc.o \
       hashtab.o intptrstack.o intstack.o matchpat.o mmodel.o print.o \
       searchpath.o segnames.o shift.o strbuf.o strpool.o strstack.o \
       strutil.o target.o version.o xmalloc.o xsprintf.o

all: libcommon.a

$(OBJS) : $(HDRS)

libcommon.a: $(OBJS)
	ar rc libcommon.a $(OBJS)
	ranlib libcommon.a

clean:
	rm -f $(OBJS) libcommon.a *~
