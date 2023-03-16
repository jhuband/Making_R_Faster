
filename <- "../Data/collectedStats.csv"

numReps = 10
start_time <- proc.time()
for (i in 1:numReps){
          raw_data <- read.csv(filename, sep="|")
}
elapsedTime <- proc.time() - start_time   

cat("\n******************\n")
print(elapsedTime/numReps)
cat("\n******************\n")
