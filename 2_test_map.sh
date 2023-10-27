#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J 1_prepare_map
#SBATCH -A proj5034

FQ_DIR=/tarafs/scratch/proj5034-AGBKU/genome_NCBI/trimmed
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
genomes=()
while IFS= read -r genome; do
    genomes+=("$genome")
done < genomes.txt

module purge
module load SAMtools/1.9-intel-2019b
module load BWA/0.7.17-intel-2019b

for seq in "${SEQ_LIST[@]}"
do
  echo "${seq}"
  for genome in "${genomes[@]}"
  do
    echo "${genome}"
    output_file="data/map/${seq}-${genome}.sam"
    if [ -f "$output_file" ]; then
      echo "Skip"
    else
      bwa mem -t 96 \
        "sequences/${seq}.fasta" \
        "${FQ_DIR}/${genome}_trimmed.fq" \
        > "data/map/${seq}-${genome}.sam"
    fi
  done
done
