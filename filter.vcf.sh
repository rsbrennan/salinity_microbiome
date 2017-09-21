#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o filt-stdout-%j.txt
#SBATCH -e filt-stderr-%j.txt
#SBATCH -J filt

module load vcftools/0.1.13

cd ~/shm/variants/

vcftools --gzvcf ~/shm/variants/all.vcf.gz \
--recode --recode-INFO-all --maf 0.05 \
--minQ 20  \
--min-alleles 2 --max-alleles 2 \
--min-meanDP 20 \
--max-meanDP 80 \
--max-missing 0.8 \
--remove-indels --stdout | bgzip > ~/shm/variants/all.filtered.vcf.gz

tabix -p vcf ~/shm/variants/all.filtered.vcf.gz

vcftools --gzvcf ~/shm/variants/all.vcf.gz \
--recode --recode-INFO-all --maf 0.05 \
--minQ 20  \
--min-alleles 2 --max-alleles 2 \
--min-meanDP 20 \
--max-meanDP 80 \
--max-missing 0.8 \
--keep ~/shm/scripts/pop.lists/fh.pop \
--remove-indels --stdout | bgzip > ~/shm/variants/fh.filtered.vcf.gz

tabix -p vcf ~/shm/variants/fh.filtered.vcf.gz
