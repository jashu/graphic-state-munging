#' The getTrial is a helper function to wideToLong and takes a string corresponding to a column
#' header in the wide format and returns the trial number embedded in that header.
#' 
#' Assumes the header follows a naming convention of 'ProtocolTimeTrial_Session'
#' where Time == 'Pre' or 'CS' ('Pre' referring to time before the CS and 'CS' referring to time
#' during the CS) and Trial == the trial number. The _Session field gives the session number
#' if there is more than one session. If there is only one session it can be omitted.

#' Example: 'ExtPre13_2' would refer to the pre-CS interval of the 13th trial of the second session of
#            extinction. The function would return '13'.
#' @importFrom stringr str_locate

getTrial = function(string)
{
  if (grepl('Pre',string))
  {
    #index for end of 'Pre' + 1 = start index for trial substring
    start_index = str_locate(string,'Pre')[2]+1
    #if there is no session specification, end index is the last char in string
    end_index = nchar(string)
    #if there is a session specification, end index is start of underscore - 1
    if (grepl('_',string)) end_index = str_locate(string,'_')[1]-1
    return (substr(string,start_index,end_index))
  }else
  {
    start_index = str_locate(string,'CS')[2]+1
    end_index = nchar(string)
    if (grepl('_',string)) end_index = str_locate(string,'_')[1]-1
    return (substr(string,start_index,end_index))
  }
}