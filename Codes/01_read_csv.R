library(readr)

setwd("~/Making_R_Faster/Codes")

filename <- "../Data/collectedStats.csv"
start_time <- proc.time()

raw_data <- read.csv(filename, sep="|")

elapsedTime <- proc.time() - start_time   

cat("\n******************\n")
print(elapsedTime)
cat("\n******************\n")
