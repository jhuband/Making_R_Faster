library(readr)


filename <- "../Data/collectedStats.csv"
start_time <- proc.time()

raw_data <- read_delim(filename, delim="|", show_col_types=FALSE)

elapsedTime <- proc.time() - start_time   

cat("\n******************\n")
print(elapsedTime)
cat("\n******************\n")
