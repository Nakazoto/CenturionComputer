#!/bin/sh
#
# This script extracts a binary from a CPU6 disk image, performs CVX on it,
# then dumps the hex of that to a file.
#
# Arguments:
#
# $1 = disk image
# $2 = executable name
# $3 = hex file name
# $4 = base address (optional - default is 0)

IMAGE="$1"
if [ "$IMAGE" = "" ]
then
  echo "Missing disk image."
  exit 1
fi

EXE="$2"
if [ "$EXE" = "" ]
then
  echo "Missing executable name."
  exit 1
fi

HEX="$3"
if [ "$HEX" = "" ]
then
  echo "Missing hex file name."
  exit 1
fi

BASE="$4"
if [ "$BASE" = "" ]
then
  BASE=0
fi

SCRIPTDIR=`dirname "$0"`
TMPFILE=`mktemp cvx.XXXXX`

if ! $SCRIPTDIR/fsscan.py -x "$IMAGE" "$EXE" > $TMPFILE
then
  echo "Extraction failed."
  exit 1
fi
EXTRACTED=`grep '^wrote' $TMPFILE | sed -e 's/^[^ ]* //' | tail -1`

if ! $SCRIPTDIR/disassm.py -cvxrel $TMPFILE -base $BASE $EXTRACTED
then
  echo "CVX failed."
  exit 1
fi

xxd -p -c 0 $TMPFILE > $HEX

rm $TMPFILE

