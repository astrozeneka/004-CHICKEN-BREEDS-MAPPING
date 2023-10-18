#!/bin/bash
#SBATCH -p compute
#SBATCH -n 1 -c 24
#SBATCH -t 24:00:00
#SBATCH -J BWAjob_ryan
#SBATCH -A proj5034

module load foss/2021b
export PATH=${PATH}:/tarafs/data/home/hrasoara/edirect
samples=()
while IFS= read -r sample; do
    samples+=("$sample")
done < biosamples.txt

mkdir -p data/biosamples-docs
for sample in "${samples[@]}"
do
  echo "${sample}"
  esearch -db biosample -query "${sample}" | efetch -format docsum
  exit
done
