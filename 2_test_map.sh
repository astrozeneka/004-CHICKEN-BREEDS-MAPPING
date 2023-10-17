#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J 1_prepare_map
#SBATCH -A proj5034

FQ_DIR=/tarafs/scratch/proj5034-AGBKU/genome_NCBI/trimmed
SEQ_LIST=(
  "LTR"
  "LTR+Int+LTR"
)
genomes=()
while IFS= read -r genome; do
    genomes+=("$genome")
done < genomes.txt

module purge
module load SAMtools/1.9-intel-2019b

for seq in "${SEQ_LIST[@]}"
do
  echo "${seq}"
  for genome in "${genomes[@]}"
  do
    echo "${genome}"
    echo bwa mem -t 96 \
      "${FQ_DIR}/${genome}_trimmed.fq" \
      ">" "data/map/${genome}.sam"
  done
done