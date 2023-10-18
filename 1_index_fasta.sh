#!/bin/bash
#SBATCH -p compute
#SBATCH -n 1 -c 24
#SBATCH -t 24:00:00
#SBATCH -J BWAjob_ryan
#SBATCH -A proj5034

module purge
module load BWA/0.7.17-intel-2019b

SEQ_LIST=(
#  "LTR"
#  "LTR+Int+LTR"
  "ENS-1-x2"
  "ENS-1-x3"
  "ENS-1-x4"
  "FlankL+LTR1"
  "FlankL"
  "FlankR"
  "LTR+FlankR"
)
cd sequences
for seq in "${SEQ_LIST[@]}"
do
  bwa index "${seq}.fasta"
done
cd ..
