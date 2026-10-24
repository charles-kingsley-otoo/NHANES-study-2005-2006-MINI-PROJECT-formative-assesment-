README

What this project is about

This project uses data from the NHANES study (2005-2006). I am looking at
physical activity (from accelerometers) and body measures ( BMI).
The aim is to find which participants have both kinds of data, so they can
be used later to look at physical activity and body measures together.

The data

1. Accelerometer data (the "accel" folder)
   - 7455 files, one for each participant, called accel-ID.txt
     (e.g. accel-31128.txt).
   - Plain text files with columns separated by tabs.
   - Line 1 of each file is <ACTIGRAPH ID=...>. This just shows the ID of
     the person, it is not real data.
   - Line 2 is the header with 8 column names.
   - Then there are 10080 rows, one for every minute for 7 days
     (7 x 24 x 60), so a full file has 10082 lines.
   - Columns: PAXSTAT, PAXCAL, PAXDAY, PAXN, PAXHOUR, PAXMINUT, PAXINTEN,
     PAXSTEP. PAXINTEN is the activity intensity and PAXSTEP is steps.

2. Body measures data (BMX_D.csv) 
   - A csv file  with one row per person.
   - It has 9950 participants.
   - The first column is just a row number. The columns I need are
     SEQN (participant ID, column 2) and BMXBMI (BMI, column 12).
     Missing BMI values are written as NA (1001 people have no BMI).

Numbers I found

- Participants with accelerometer data: 7455
- Participants with body measures: 9950
- Participants with BOTH accelerometer data and a BMI value: 7425
  (this is the number of 1s in results/sample.csv. 2525 participants
  have a 0)

Problems I found in the accelerometer files

1. All 7455 files have the <ACTIGRAPH ID=...> line at the top, so the
   header is on line 2 and not line 1.
2. 25 lines in total only had 3 columns instead of 8. They were rows
   saying NA NA NA at the end of two files:
   - accel-31268.txt (10 extra lines)
   - accel-34974.txt (15 extra lines)
3. Some files are shorter than 10082 lines. I think this is because some
   people did not wear the monitor for the whole 7 days. I left these
   as they are because they are real data and not a mistake.

Things that were OK

- The header on line 2 was the same in every file.
- No Windows line endings (checked with grep for \r).
- All other lines had exactly 8 columns.

How I fixed the problems (fixing_files.sh)

I copied the original files into data/derived/accel and then, in the
copies, deleted line 1 and deleted every line starting with NA. After this
every file starts with the header and every line has 8 columns. The
files in data/original were not changed. I ran check_files.sh again on the
cleaned files to check it had worked.

Scripts (all in the code folder)
-
- files_checking.sh  : checks the accelerometer files for problems (first line,
                    header, number of columns, NA lines, number of lines)
- fixing_files.sh : fixes the problems and saves clean files in
                    data/derived/accel
- sample_gen.sh  : generates results/sample.csv with the participant ID and a
                    1 or 0. 1 means they have accelerometer data AND a BMI
                    value, 0 means they do not.

Order to run the scripts
------------------------
1. bash files_checking.sh     (on the original files)
2. bash fixing_files.sh
3. bash files_checking.sh     (on the cleaned files, to check it worked)
4. bash sample_gen.sh