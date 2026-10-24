#!/bin/bash


# 1. IDs with accelerometer data, taken from the cleaned file names
ls ../data/derived/accel | sed 's/accel-//' | sed 's/.txt//' | sort > ../data/derived/acc_ids.txt

# 2. IDs that have a BMI value.
tail -n +2 ../data/original/BMX_D.csv | cut -d',' -f1,12 | grep -v ',$' | cut -d',' -f1 | sort > ../data/derived/bmi_ids.txt

# 3. Every ID in the body measures file
tail -n +2 ../data/original/BMX_D.csv | cut -d',' -f1 | sort > ../data/derived/bmx_ids.txt

# 4. Every ID from either dataset. cat joins the lists, sort -u removes repeats
cat ../data/derived/acc_ids.txt ../data/derived/bmx_ids.txt | sort -u > ../data/derived/all_ids.txt

# 5. IDs in BOTH the accelerometer list and the BMI list.
comm -12 ../data/derived/acc_ids.txt ../data/derived/bmi_ids.txt > ../data/derived/both_ids.txt

# 6. Adding ",1" to the end of each ID in the both list
sed 's/$/,1/' ../data/derived/both_ids.txt > ../data/derived/ones.txt


comm -23 ../data/derived/all_ids.txt ../data/derived/both_ids.txt | sed 's/$/,0/' > ../data/derived/zeros.txt

# 8. Startimg the sample file with a header line 
echo "SEQN,in_sample" > ../results/sample.csv

# 9. Join the 1s and 0s, sort them, and add them to the file ('>>' adds to the end)
cat ../data/derived/ones.txt ../data/derived/zeros.txt | sort >> ../results/sample.csv 