# **********************************************************************
#   Slow Code Example 
#
#   This code reads a series of coordinates (x, y, z)  and charges (q) from 
#    the file specified as argument 1 on the command line.
# 
#    The input file should have the format:
#       I9
#       4F10.4   (repeated I9 times representing x,y,z,q)
# 
#   It then calculates the following made-up function:
#   
#              exp(rij*qi)*exp(rij*qj)   1
#     E = Sum( ----------------------- - - )  (rij <= cut)
#         j<i           r(ij)            a
# 
#   where cut is a cut off value specified as argument 2 on the command line, 
#   r(ij) is the distance between (xi, yi, zi) and (xj, yj, zj) 
#   a is the constant 3.2.
# 
#   The code prints out the number of atoms, the cut off, total number of
#   atom pairs which were less than or equal to the distance cutoff, the
#   value of E, the time take to generate the coordinates and the time
#   taken to perform the calculation of E.
# 
# **********************************************************************
  
library(dplyr)

#   
#   Step 5 - for each pair of coordinates, compute the distance.
#   If the distance is less than or equal to the cut, calculate the term
#   for E. Keep track of the number of pairs that are used.
total_e = 0.0
cut_count = 0

load("../Data/coords.RData")
load("../Data/q_values.RData")
natom <- 5000
cut <- 0.01
a <- 3.2
a_inv <- 1.0/a

time1 <- proc.time()
N <- natom - 1

for (i in 2:N){
   j <- 1:(i-1)

   vec2 = (coords[i, 1]-coords[j, 1])^2.0 + (coords[i, 2]-coords[j, 2])^2.0 + (coords[i, 3]-coords[j,3])^2
   ri <-  sqrt(vec2)
   ndx <- which(ri <= cut)
   num_making_cut <- length(ndx)
   
   if (num_making_cut > 0){

     cut_count <- cut_count + 1
     jcut <- j[ndx]
     qj <- q[jcut]
     rij <- ri[jcut]

     current_e = sum(exp(rij*(q[i]+qj)))/rij
     total_e <- total_e + current_e - a_inv
     
   }
}
   



time2 = proc.time(); #time after reading of file and calculation 
elapsedTime2 = time2 - time1
cat("Value of system clock after coord read and E calc = \n")
print(time2)


#   
#   Step 6 - write out the results 
cat("                         Final Results\n")
cat("                         -------------\n")
cat("                   Num Pairs = ",cut_count, "\n")
cat("                     Total E = ",total_e, "\n")
cat("         Time to calculate E =", as.numeric(elapsedTime2[3]), "Seconds\n") 
