#5-Choice Data Extractor
## Script for extracting total number of correct and incorrect repsonses for each port from a five-choice-serial-reaction-time dataset.

**Assumptions**
1. All files to be read are located in the following directory relative to the R working directory: /StudyName/raw_data/
2. All files to be read have been saved as tab-delimited txt files.
3. All files to be read have the naming convention of beginning with the date in 6 digit format: mmddyy
4. Data in each file are unique. There is no error checking for duplicate files.

**What the program will do**
1. Prompt you for the name of your study, i.e., the folder corresponding to StudyName in Assumption 1.
2. Read all files in the raw_data folder ending with the extension .txt
3. Write two new files in the main /StudyName directory:
a. tidy.txt file: for each subject on each date, gives the total number of correct and incorrect responses for each port number
b. summary.txt file: for each subject on each date, gives the total number of correct and incorrect responses summed across all ports 

**Notes**
1. The tidy and summary txt files can be opened from Excel using all the default file import settings.
2. After running the script, if you need to run it again, you will first need to either
  a. Delete the previously created tidy.txt file (recommended if you edit or change files and need to re-run).
  OR
  b. Delete the raw.txt files that you've already processed or move them to a different directory (recommended if you just want to add new files to the dataset).    
**IMPORTANT:**Failing to follow this procedure will result in duplicate data points and erroneous port entry counts in the final output. If this should happen, just delete the tidy.txt file and rerun script on all files.