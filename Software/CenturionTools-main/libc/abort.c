/*
 *	FIXME: should do an fflushall IFF stdio is in use
 */
#include <unistd.h>
#include <stdlib.h>

void abort(void)
{
	/* No signals for abort on this platform so just exit */
	_exit(255);
}
