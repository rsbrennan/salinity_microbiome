#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o tobed-stdout-%j.txt
#SBATCH -e tobed-stderr-%j.txt
#SBATCH -J tobed

cd ~/shm/variants/

for i in all fh_fd fh fh.potomac fh.james fh.potomac.admix_J7_remove fh.potomac.admix_remove;
do

	~/bin/plink --file ${i}.thinned \
	--make-bed --allow-extra-chr \
	--out ${i}

done
