#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o pca-stdout-%j.txt
#SBATCH -e pca-stderr-%j.txt
#SBATCH -J pca

# mod 2017-01-11

cd ~/shm/variants/

#pca

~/bin/plink --file all.thinned \
--pca header --allow-extra-chr --out ~/shm/results/all.thinned


#fh_fd only
~/bin/plink --file fh_fd.thinned \
--pca header --allow-extra-chr --out ~/shm/results/fh_fd.thinned

#fh only
~/bin/plink --file fh.thinned \
--pca header --allow-extra-chr --out ~/shm/results/fh.thinned

