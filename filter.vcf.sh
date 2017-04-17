#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o filt-stdout-%j.txt
#SBATCH -e filt-stderr-%j.txt
#SBATCH -J filt

cd ~/shm/variants/

~/bin/vcftools/bin/vcftools --gzvcf ~/shm/variants/all.vcf.gz \
--recode --recode-INFO-all --maf 0.05 \
--minQ 20 --minGQ 30 \
--min-alleles 2 --max-alleles 2 \
--min-meanDP 8 \
--max-missing 0.8 \
--remove-indels --stdout | bgzip > ~/shm/variants/all.filtered.vcf.gz

tabix -p vcf ~/shm/variants/all.filtered.vcf.gz

