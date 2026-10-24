#!/bin/bash


# Deleting any old derived copy first, so it is safe to run this script again
rm -rf ../data/derived/accel

# Copying the original folder into derived
cp -r ../data/original/accel ../data/derived/accel

# Deleting line 1 (the <ACTIGRAPH ...> line) in every copied file.
# On a Mac, sed -i needs the empty '' after it
sed -i '' '1d' ../data/derived/accel/*.txt

# Deleting lines that start with NA in every copied file
sed -i '' '/^NA/d' ../data/derived/accel/*.txt

echo "Finished. Clean files are in data/derived/accel"