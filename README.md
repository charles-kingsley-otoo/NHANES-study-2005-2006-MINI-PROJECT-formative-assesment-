# NHANES formative project

Analysis of NHANES 2005-2006 physical activity monitor data and body measures data.

## THE Folder structure
- code/    scripts (check_files.sh, fixing_files.sh, make_sample.sh)
- data/    raw and derived data (not included in this repository)
- results/ output files, e.g. sample.csv
- environment.yml  the Conda environment
## How to create the Conda environment

1. Install Conda (Miniconda or Anaconda).
2. Open a terminal in the top-level formative folder.
3. Create the environment from the file:
   conda env create -f environment.yml
4. Activate it:
   conda activate formative-env
5. Check it works (should load the tidyverse without errors):
   Rscript -e "library(tidyverse)

## Data
The data are not included because it was provided by my University. 
