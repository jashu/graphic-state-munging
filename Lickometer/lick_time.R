#The lick_time function takes as its input a data frame/table corresponding to the raw-data export
#format provided by Graphic State, which gives time stamps corresponding to when the lickometer is
#switched on and off, and returns the total time spent drinking.

lick_time = function(df)
{
  drink_time = 0
  it = 1
  while (it < nrow(df))
  {
    if (df$Lick[it] == 1 & df$Lick[it+1] == 0)
    {
      drink_time = drink_time + df$Time[it+1] - df$Time[it]
      it = it + 1
    }
    if (df$Lick[it] == 1 & df$Lick[it+1] == 1)
    {
      start = df$Time[it]
      while (it < nrow(df) & df$Lick[it] == 1)
      {
        it = it + 1
      }
      end = df$Time[it]
      drink_time = drink_time + end - start
      it = it + 1 
    }
    else
    {
      it = it + 1
    }
    
  }
  df$Drink.Time = drink_time/10 #One Graphic State time unit is equal to 100 ms. Divide by 10 to get s.
  return(df)
}