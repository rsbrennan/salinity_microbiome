#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o pca-stdout-%j.txt
#SBATCH -e pca-stderr-%j.txt
#SBATCH -J pca

# mod 2017-01-11

cd ~/shm/results/

#pca

#~/bin/plink --file all.thinned \
#--pca header --allow-extra-chr --out ~/shm/results/all.thinned


for i in all fh_fd fh;
do

	~/bin/flashpca/flashpca --bfile ~/shm/variants/${i} --suffix .${i}.txt

done
