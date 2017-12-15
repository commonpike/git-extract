#!/bin/bash

BRANCH=$1
INDIR=$2
OUTDIR=$3
TMPDIR=/tmp/git-extract

if [ "$BRANCH" = "" ]; then
	echo Usage: $0 branch indir outdir
	exit 1
fi

if [ "$INDIR" = "" ]; then
	echo Usage: $0 branch indir outdir
	exit 1
fi

if [ "$OUTDIR" = "" ]; then
	echo Usage: $0 branch indir outdir
	exit 1
fi

if [ -d "$OUTDIR" ]; then
	echo Output dir $OUTDIR exists, wont overwrite.
	exit 1
fi

if [ ! -d "`dirname $OUTDIR`" ]; then
	echo Output dir `dirname $OUTDIR` does not exist.
	exit 1
fi


mkdir -vp $TMPDIR
if [ ! -d "$TMPDIR" ]; then
	echo "Cant create $TMPDIR"
	exit 1
fi

# ===================

git archive $BRANCH $INDIR | tar -x -C $TMPDIR
if [ "$INDIR" = "." ]; then
	mv -v $TMPDIR $OUTDIR
else
	#echo "mv -v $TMPDIR/$INDIR $OUTDIR"
	mv -v $TMPDIR/$INDIR $OUTDIR
	rm -rv $TMPDIR
fi


# ===================

echo Done. See $OUTDIR.

