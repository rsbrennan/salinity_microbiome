#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o count.demulti-stdout-%j.txt
#SBATCH -e count.demulti-stderr-%j.txt
#SBATCH -J count.demulti

# mod 2017-01-11

cd ~/shm/processed_data/demultiplex/

for i in $(ls *RA.fastq | cut -c -8)

do {
FORWARD=$(cat ${i}_RA.fastq | wc -l) #forward reads
echo ${i},$FORWARD

  } >> ~/shm/summary_files/count.demultiplex.txt

done
