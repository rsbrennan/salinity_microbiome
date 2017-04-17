#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o cat.var-stdout-%j.txt
#SBATCH -e cat.var-stderr-%j.txt
#SBATCH -J cat.var

cd ~/shm/variants/all/

vcf-concat $(ls -1 ~/shm/variants/all/*.vcf | perl -pe 's/\n/ /g') |\
vcf-sort -c |\
bgzip -c > ~/shm/variants/all.vcf.gz

