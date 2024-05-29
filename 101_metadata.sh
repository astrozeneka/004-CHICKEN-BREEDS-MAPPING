#!/bin/bash
#SBATCH -p compute
#SBATCH -n 1 -c 24
#SBATCH -t 24:00:00
#SBATCH -J BWAjob_ryan
#SBATCH -A proj5034

module load foss/2021b
export PATH=${PATH}:/tarafs/data/home/hrasoara/edirect

genomes=()
while IFS= read -r genome; do
    genomes+=("$genome")
done < genomes-all.txt

mkdir -p data/sra-docs
for genome in "${genomes[@]}"
do
  echo "${genome}"
  esearch -db sra -query SRR20726720 | efetch -format docsum > "data/sra-docs/${genome}.xml"
done
