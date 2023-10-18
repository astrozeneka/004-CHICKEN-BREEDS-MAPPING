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
  "ENS-1-x2"
  "ENS-1-x3"
  "ENS-1-x4"
  "FlankL+LTR1"
  "FlankL"
  "FlankR"
  "LTR+FlankR"
)
genomes=()
while IFS= read -r genome; do
    genomes+=("$genome")
done < genomes.txt
echo "" > data/mapping-plain.tsv
for seq in "${SEQ_LIST[@]}"
do
  echo "${seq}"
  for genome in "${genomes[@]}"
  do
    echo "${genome}"
    count=$(samtools view -c "data/only-map/${seq}-${genome}.sam")
    echo "${seq}  ${genome} ${count}" >> data/mapping-plain.tsv
    
  done
done
