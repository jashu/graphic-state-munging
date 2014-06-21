#The label_trials function takes as its input a data frame or table corresponding to the raw-data export
#format provided by Graphic State and assigns a trial number to each row of the data frame/table.

#The algortihm uses the Current.State variable to determine when the trial should be incremented.
#This assumes the following state notation in the Graphic State protocols:
#   State 1 == the ITI
#   State 2 == the pre-CS interval (in our programs, the 20 sec preceding each CS when the DVR is turned on)
#   State 3 == the CS
#   State 4 == the US (only exists in the acquisition protocol)
#A trial ends and a new one begins when the states cycle back from 3 to 1 (or 4 to 1 in the case of acquisition).

label_trials = function(df)
{
  if (df$Protocol[1] == 4) trial = 2 else trial = 1
  # if this is an extinction session following a retrieval trial, begin the trial count at 2
  # instead of 1
  
  for (x in 1:nrow(df))
  {
    df$Trial[x] = trial
    if (x != nrow(df) & (df$State[x] == 3 | df$State[x] == 4) & df$State[x+1] == 1)
    {trial <- trial + 1}
  }
  return (df)
}