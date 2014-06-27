# Script for extracting total number of correct and incorrect repsonses for each port from a five-choice data set.

# Assumptions:
## 1. All files to be read are located in the following directory: /StudyName/raw_data/
## 2. All files to be read have been saved as tab-delimited txt files.
## 3. All files to be read have the naming convention of beginning with the date in 6 digit format: mmddyy
## 4. Data in each file are unique. There is no error checking for duplicate files.

# What the program will do:
## 1. Prompt you for the name of your study, i.e., the folder corresponding to StudyName in Assumption 1.
## 2. Read all files in the raw_data folder ending with the extension .txt
## 3. Write two new files in the main /StudyName directory:
### a. tidy.txt file: for each subject on each date, gives the total number of correct and incorrect responses for each port number
### b. summary.txt file: for each subject on each date, gives the total number of correct and incorrect responses summed across all ports 

# Notes:
## 1. The tidy and summary txt files can be opened from Excel using all the default file import settings.
## 2. After running the script, if you need to run it again, you will first need to either
###       a. Delete the previously created tidy.txt file. 
####          (recommended if you edit or change files and need to re-run)
###   OR  b. Delete the raw.txt files that you've already processed or move them to a different directory. 
####          (recommended if you just want to add new files to the dataset)    
###   Failing to follow this procedure will result in duplicate data points and erroneous port entry counts
###   in the final output. If this should happen, just delete the tidy.txt file and rerun script on all files.

require(reshape2)
require(data.table)
require(plyr)

get_all_responses = function(file,study){
  filename = paste(study,'/raw_data/',file,sep="")
  data=fread(filename,skip=1,select=c(4,8,10,11,13,15,27,29))
  setnames(data,3,'CorrectPort')
  data = subset(data, Protocol != 11 & ((CorrectPort > 1 & CorrectPort < 8) | (CorrectPort > 13 & CorrectPort < 19)))
  data = melt(data, c(1,2,3),variable.name='ResponsePort',value.name='NumResponses')
  data$ResponsePort = as.character(data$ResponsePort)
  data$ResponsePort[data$ResponsePort=='A1'] = 1
  data$ResponsePort[data$ResponsePort=='A2'] = 2
  data$ResponsePort[data$ResponsePort=='A3'] = 3
  data$ResponsePort[data$ResponsePort=='B1'] = 5
  data$ResponsePort[data$ResponsePort=='B2'] = 4
  data$CorrectResponse = F; data$CorrectResponse[data$CorrectPort == 7] = T
  data$WhenResponse[data$CorrectPort < 7] = 'Port Light'
  data$WhenResponse[data$CorrectPort > 7] = 'Grace Period'
  data$CorrectPort[data$CorrectPort < 7] = data$CorrectPort[data$CorrectPort < 7] - 1
  data$CorrectPort[data$CorrectPort > 7] = data$CorrectPort[data$CorrectPort > 7] - 13
  data$CorrectPort[data$CorrectResponse] = data$ResponsePort[data$CorrectResponse]
  data$Protocol[data$Protocol==13] = '500ms'
  data$Protocol[data$Protocol==14] = '100ms'
  data$Protocol[data$Protocol==17] = 'blink'
  data = aggregate(NumResponses ~ Protocol + Subject + CorrectPort + ResponsePort + CorrectResponse, data=data, FUN = sum)
  data = arrange(data,Protocol,Subject,CorrectResponse,CorrectPort,ResponsePort)
  data$Date = as.Date(substr(file,1,6),'%m%d%y')
  newfile = paste(study,"/",study,"_","tidy.txt",sep="")
  if (file.exists(newfile)) {
    col.names = F
    append = T
  }
  else{
    col.names = T
    append = F
  }
  write.table(data,newfile,row.names=F,col.names=col.names,append=append,sep='\t')
}


study = readline('Enter the name of the study to analyze: ')
folder= paste(study,'/raw_data',sep="")
files = list.files(folder,'.txt')
lapply(files,get_all_responses,study)
tidy_data = read.delim(paste(study,"/",study,"_","tidy.txt",sep=""),header=T)
summary_data = aggregate(NumResponses ~ Protocol + Subject + Date + CorrectResponse, data=tidy_data, FUN = sum)
newfile = paste(study,"/",study,"_","summary.txt",sep="")
write.table(summary_data,newfile,row.names=F,sep='\t')
