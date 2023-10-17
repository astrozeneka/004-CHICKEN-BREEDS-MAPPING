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
