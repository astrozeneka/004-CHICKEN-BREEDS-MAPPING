#!/bin/bash
#SBATCH -p compute
#SBATCH -n 1 -c 24
#SBATCH -t 24:00:00
#SBATCH -J BWAjob_ryan
#SBATCH -A proj5034

module purge
module load SAMtools/1.9-intel-2019b
SEQ_LIST=(
  "LTR"
  "LTR+Int+LTR"
)
genomes=()
while IFS= read -r genome; do
    genomes+=("$genome")
done < genomes.txt

for seq in "${SEQ_LIST[@]}"
do
  echo "${seq}"
  for genome in "${genomes[@]}"
  do
    echo "${genome}"
    samtools view -F 4 "data/map/${seq}-${genome}.sam"
  done
done