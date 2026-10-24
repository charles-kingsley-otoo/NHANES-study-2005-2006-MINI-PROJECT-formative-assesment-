#!/bin/bash


#SECTION 1


echo "Checking the first line of every file"
awk 'FNR==1' ../data/original/accel/*.txt | cut -c1-10 | sort | uniq -c

echo "Checking the header line (should be the same in every file)"
awk 'FNR==2' ../data/original/accel/*.txt | sort | uniq -c

echo "Checking number of columns on every line (should only be one number)"
awk -F'\t' '{print NF}' ../data/original/accel/*.txt | sort | uniq -c

echo "Checking files with lines starting with NA"
grep -l "^NA" ../data/original/accel/*.txt

echo "Checking files that are not exactly 10082 lines long"
wc -l ../data/original/accel/*.txt | grep -v " 10082 " | sort -n | head

echo "Files checking succesfullily done"