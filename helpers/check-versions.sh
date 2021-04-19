#/bin/bash

set -e

# Make sure the versions defined in main.text and main.adoc coincide
# Use from project dir:
# sh check-versions.sh main.tex main.adoc
TEX_SRC="$1"
ADOC_SRC="$2"

if [ ! -f "$TEX_SRC" ]; then
	echo "Main tex file (${TEX_SRC}) could not be found. Did you call the script with the proper arguments?"
	exit 1
fi

if [ ! -f "$ADOC_SRC" ]; then
	echo "Main adoc file (${ADOC_SRC}) could not be found. Did you call the script with the proper arguments?"
	exit 1 
fi

# There are probably more elegant ways of grepping this
# But it works well enough.
LATEX_DIGIT_VERSION=$(cat "$TEX_SRC" | \
	grep Revision\ version |
	sed 's=\\digitalEditionInfo{\\textit{Revision version ==' | \
	cut -d '}' -f 1,4)

ADOC_VERSION=$(cat "$ADOC_SRC" | grep :version: | sed "s/:version: v//")

if [ "$LATEX_DIGIT_VERSION" != "$ADOC_VERSION" ]; then
	echo "Version do to no match; in main.tex: $LATEX_DIGIT_VERSION, in main.adoc: $ADOC_VERSION"
	exit 1
fi
