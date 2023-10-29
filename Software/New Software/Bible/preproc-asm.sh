#!/bin/sh
#
# This script preprocesses assembly to minimize size.
sed -e '/^\*/d' \
    -e 's/  *\([^ ][^ ]*\)  */ \1 /' \
    -e "s/ *;[^']*\$//" \
    -e "/'.*'/!s/  */ /g" \
    -e 's/  *$//' \
    -e 's/\(^[^ ]* [[:alpha:]][[:alpha:]]*[-/=$]\) /\1/' \
    -e 's/\(^[^ ]* [[:alpha:]][[:alpha:]]*+\) /\1/' \
    -e 's/\(^[^ ]* [[:alpha:]][[:alpha:]]*\*\) /\1/' \
    -e 's/\(^[^ ]* [[:alpha:]][[:alpha:]][[:alpha:]]*\) \([-/=\(]\)/\1\2/' \
    -e "s/\(^[^ ]* DC\) \('\)/\1\2/" \
    $1

