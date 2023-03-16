library(readr)
library(future)
library(furrr)


##---------- Compute CPU Hours-----------------------##
## Given a single value, say 5-01:30:10 or 12:15:05
## Split the string into the numeric parts and convert each part to hours.
##
convert_time_to_hrs <- function(cputime){
  parts <- as.numeric(unlist(strsplit(cputime, "[[:punct:]]")))
  cpuhours <- 0
  if (length(parts)==4){
    cpuhours <- parts[1]*24
    parts <- parts[-1]  #Remove the days part from the array
  }
  cpuhours <- cpuhours + parts[1] + parts[2]/60 + parts[3]/3600
  return(cpuhours)
}


filename <- "../Data/collectedStats.csv"
if (file.exists(filename)) {
   raw_data <- read_delim(filename, delim="|", show_col_types=FALSE)

   plan("multisession", workers=4)

   start_time <- proc.time()
   raw_data$CPUHours <- unlist(future_map(raw_data$CPUTime, convert_time_to_hrs))
   elapsed_time <- proc.time() - start_time
   print(elapsed_time)
   print("******************")
   print(head(raw_data))

} else {
   cat("\nThe file,", filename, "does not exist.\n\n")
}


