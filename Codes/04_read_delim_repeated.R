library(readr)

filename <- "../Data/collectedStats.csv"
numReps = 10
start_time <- proc.time()

#replicate(numReps,      
for(i in 1:numReps){
     raw_data <- read_delim(filename, delim="|", num_threads=1, show_col_types=FALSE )
}
#)
elapsedTime <- proc.time() - start_time       

cat("\n******************\n")
print(elapsedTime/numReps)
cat("\n******************\n")

