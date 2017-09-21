#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o pca-stdout-%j.txt
#SBATCH -e pca-stderr-%j.txt
#SBATCH -J pca

# mod 2017-01-11

cd ~/shm/results/

	sed -i 's/^23/x23/g' ~/shm/variants/all.thinned.map
	sed -i 's/^23/x23/g' ~/shm/variants/fh.map

	~/bin/plink --file  ~/shm/variants/all.thinned \
	--pca header --allow-extra-chr --out ~/shm/analysis/pca/all

        ~/bin/plink --file  ~/shm/variants/fh \
        --pca header --allow-extra-chr --out ~/shm/analysis/pca/fh

