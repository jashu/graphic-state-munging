#The getTrial is a helper function to wideToLong and takes a string corresponding to a column header
#in the wide format and returns the trial number embedded in that header.

#Assumes the header follows a naming convention of 'ProtocolTimeTrial_Session'
#where Time == 'Pre' or 'CS' ('Pre' referring to time before the CS and
#               'CS' referring to time during the CS) 
#and Trial == the trial number.

#Example: 'ExtPre13_2' would refer to the pre-CS interval of the 13th trial of the second session of
#          extinction. The function would return '13'.

getTrial = function(string)
{
  if (grepl('Pre',string))
  {
    start_index = str_locate(string,'Pre')[2]+1
    end_index = str_locate(string,'_')[2]-1
    return (substr(string,start_index,end_index))
  }
  else
  {
    start_index = str_locate(string,'CS')[2]+1
    end_index = str_locate(string,'_')[2]-1
    return (substr(string,start_index,end_index))
  }
}