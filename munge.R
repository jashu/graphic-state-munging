#This script outlines an example of how to munge a lickometer data set using the functions in this repo.
library(Lickometer); library(plyr)

##First, Graphic State will create separate export files for each of your protocols.
##You will need to copy those .txt files to your working directory and assign each one to a data.table.
library(data.table)
##For example:
hab = fread('hab.tsv') #Habituation session
ret = fread('ret.tsv') #Single-trial retrieval session
ext17 = fread('ext17.tsv') #Extinction session following a retrieval session
ext18 = fread('ext18.tsv') #Normal extinction session
ltm = fread('ltm.tsv') #Long-term memory test session
sr = fread('sr.tsv') #Spontaneous recovery session

#For some reason, headers for exported files from habituation session are somewhat inconsistent from the
#rest of the files at the moment. This is a temporary fix until the Graphic State habituation program is fixed.
setnames(hab,names(sr))

#Put the names of the data.tables you created above inside the list() below. Separate with commas.
dataList = list(hab,ret,ext17,ext18,ltm,sr)
dataList = lapply(dataList,getLickData)
dataList[[6]]$Session = 3 #spontaneous recovery will likely be exported separately from other LTM tests
                          #this assumes that it is the third LTM test (after 24-hour LTM and reinstatement)
                          #modify the session number to match your experimental design, or
                          #delete this line if you did not run a spontaneous recovery session

data = rbind.fill(dataList) #end product with all of your data ready for analysis

