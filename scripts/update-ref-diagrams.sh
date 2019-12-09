#!/bin/bash -e
#set -x

# Get the latest diagram files and copy them into the SQL reference
# Assumes that the sparksql-parser project hasbeen checked out into the same source directory
# or clones it there if it does not already exist

if [ ! -d ../sparksql-parser ]; then
    echo "Cloning parser repo"
    ( cd .. && git clone git@github.ibm.com:SqlServiceWdp/sparksql-parser.git )
fi

echo "Updating sparksql-parser project"
( cd ../sparksql-parser && \
  git checkout master && \
  git fetch && \
  git reset --hard origin/master \
) || { echo "Could not switch to master branch"; exit 1; }

echo "Copying SVG files"
cp ../sparksql-parser/rrd/SqlReference/*.svg ./sqlref/svgfiles/
