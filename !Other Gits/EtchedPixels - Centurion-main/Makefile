all: centurion

CFLAGS = -g3 -Wall -pedantic

centurion: centurion.o cpu6.o

centurion.o: centurion.c cpu6.h

cpu6.o : cpu6.c cpu6.h

clean:
	rm -f centurion *.o *~

