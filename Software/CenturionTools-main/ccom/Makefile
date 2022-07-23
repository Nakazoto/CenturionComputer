HDRS = anonname.h asmcode.h asmlabel.h asmstmt.h assignment.h casenode.h \
       codeent.h codegen.h codelab.h codeopt.h codeseg.h compile.h dataseg.h \
       datatype.h declare.h declattr.h error.h exprdesc.h expr.h funcdesc.h \
       function.h global.h goto.h hexval.h ident.h incpath.h input.h \
       lineinfo.h litpool.h loadexpr.h locals.h loop.h macrotab.h opcodes.h \
       output.h pragma.h preproc.h reginfo.h scanner.h scanstrbuf.h segments.h \
       shiftexpr.h stackptr.h standard.h stdnames.h stmt.h swstmt.h symentry.h \
       symtab.h testexpr.h textlist.h typecmp.h typeconv.h util.h

OBJS = anonname.o asmcode.o asmlabel.o asmstmt.o assignment.o casenode.o \
       codegen.o codelab.o codeopt.o codeseg.o compile.o dataseg.o datatype.o \
       declare.o declattr.o error.o expr.o exprdesc.o funcdesc.o function.o \
       global.o goto.o hexval.o ident.o incpath.o input.o lineinfo.o litpool.o \
       loadexpr.o locals.o loop.o macrotab.o main.o output.o pragma.o \
       preproc.o scanner.o scanstrbuf.o segments.o shiftexpr.o stackptr.o \
       standard.o stdnames.o stmt.o swstmt.o symentry.o symtab.o testexpr.o \
       todo.o typecmp.o typeconv.o util.o
       
LIB = ../common/libcommon.a

CFLAGS += -I../common/ -Wall -pedantic

all: ccwrx

ccwrx:  $(LIB) $(OBJS)
	$(CC) -o ccwrx $(OBJS) $(LIB) -lm

$(OBJS) : $(HDRS)

clean:
	rm -f $(OBJS) *~ ccwrx

