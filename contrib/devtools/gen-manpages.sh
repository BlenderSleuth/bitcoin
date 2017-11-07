#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

SCHLEEMSD=${SCHLEEMSD:-$SRCDIR/schleemsd}
SCHLEEMSCLI=${SCHLEEMSCLI:-$SRCDIR/schleems-cli}
SCHLEEMSTX=${SCHLEEMSTX:-$SRCDIR/schleems-tx}
SCHLEEMSQT=${SCHLEEMSQT:-$SRCDIR/qt/schleems-qt}

[ ! -x $SCHLEEMSD ] && echo "$SCHLEEMSD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
SLMVER=($($SCHLEEMSCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for schleemsd if --version-string is not set,
# but has different outcomes for schleems-qt and schleems-cli.
echo "[COPYRIGHT]" > footer.h2m
$SCHLEEMSD --version | sed -n '1!p' >> footer.h2m

for cmd in $SCHLEEMSD $SCHLEEMSCLI $SCHLEEMSTX $SCHLEEMSQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${SLMVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${SLMVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
