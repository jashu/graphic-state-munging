#' The getSession is a helper function to wideToLong and takes a string corresponding to a column
#' header in the wide format and returns the session number embedded in that header.
#' 
#' Assumes the header follows a naming convention of 'ProtocolTimeTrial_Session'
#' where Time == 'Pre' or 'CS' ('Pre' referring to time before the CS and 'CS' referring to time
#' during the CS) and Trial == the trial number. The _Session field gives the session number
#' if there is more than one session. If there is only one session it can be omitted.

#' Example: 'ExtPre13_2' would refer to the pre-CS interval of the 13th trial of the second session of
#            extinction. The function would return '2'.
#' @importFrom stringr str_locate

getSession = function(string)
{
  if (!grepl('_',string)) stop ('There is no session num in label, or label is improperly formatted.')
  start_index = str_locate(string,'_')[2]+1
  end_index = nchar(string)
  return (substr(string,start_index,end_index))
}