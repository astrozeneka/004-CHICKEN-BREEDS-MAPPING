#!/bin/bash
#SBATCH -p compute
#SBATCH -n 1 -c 24
#SBATCH -t 24:00:00
#SBATCH -J BWAjob_ryan
#SBATCH -A proj5034

module purge
module load BWA/0.7.17-intel-2019b

SEQ_LIST=(
  "LTR"
  "LTR+Int+LTR"
)
cd sequences
for seq in "${SEQ_LIST[@]}"
do
  bwa index "sequences/${seq}.fasta"
done
cd ..