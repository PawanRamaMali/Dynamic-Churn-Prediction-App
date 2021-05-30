###################
# functions.R


## SIMPLE GREETING
good_time <- function() {
  ## LOAD PACKAGE
  require(lubridate, quietly = T)
  
  ## ISOLATE currHour
  currhour = hour(now())
 
  ## RUN LOGIC
  if (currhour < 12) {
    return(gm)
  }
  else if (currhour >= 12 & currhour < 17) {
    return(ga)
  }
  else if (currhour >= 17) {
    return(ge)
  }
}

