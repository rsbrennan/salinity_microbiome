#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o index-stdout-%j.txt
#SBATCH -e index-stderr-%j.txt
#SBATCH -J index.bam

cd ~/shm/processed_data/aligned/all/

for i in $(ls *.bam)

do {
samtools index ${i}
  }
done
