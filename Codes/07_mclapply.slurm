#!/bin/bash

#SBATCH -p instructional 
#SBATCH -n 1 
#SBATCH -c 5 
#SBATCH -A rivanna-training 
#SBATCH -t 00:02:00 
#SBATCH -o mclapply_results.out

module load goolf/7.1.0_3.1.4 R/4.1

Rscript 07_mclapply.R
