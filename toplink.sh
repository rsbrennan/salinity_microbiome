#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o toplink-stdout-%j.txt
#SBATCH -e toplink-stderr-%j.txt
#SBATCH -J toplink

# mod 2017-01-11

module load vcftools/0.1.13

cd ~/shm/variants/

zcat ~/shm/variants/all.filtered.vcf.gz  |\
vcftools --vcf - \
--plink --chrom-map ~/shm/variants/all.plink-chrom-map.txt --out all

#think markers for ld
~/bin/plink --file all --indep 50 5 2 \
--allow-extra-chr \
--out all

#think markers for ld for fh, fd only
~/bin/plink --file all --indep 50 5 2 \
--allow-extra-chr \
--keep ~/shm/scripts/fh_fd.txt \
--out fh_fd

#think markers for ld for fh only
~/bin/plink --file all --indep 50 5 2 \
--allow-extra-chr \
--keep ~/shm/scripts/fh.txt \
--out fh

# output thinned ped

~/bin/plink --file all --extract all.prune.in --recode --allow-extra-chr \
--out all.thinned

# output thinned ped fh and fd

~/bin/plink --file all --extract fh_fd.prune.in --recode --allow-extra-chr \
--keep ~/shm/scripts/fh_fd.txt \
--out fh_fd.thinned

# output thinned ped fh

~/bin/plink --file all --extract fh.prune.in --recode --allow-extra-chr \
--keep ~/shm/scripts/fh.txt \
--out fh.thinned

