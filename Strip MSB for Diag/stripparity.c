#include <stdio.h>

int main (int argc, char *argv[])
{
	FILE *fp;
	
	if (argc != 2)
	{
		printf ("Usage: %s romfile.bin\n", argv[0]);
		return -1;
	}
	
	fp = fopen (argv[1], "rb");

	while (!feof(fp))
	{
		int c = fgetc (fp);
		putchar (c & 0x7F);
	}

	fclose (fp);

	return 0;
}
