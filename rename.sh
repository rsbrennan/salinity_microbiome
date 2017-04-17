#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o rename-stdout-%j.txt
#SBATCH -e rename-stderr-%j.txt
#SBATCH -J rename


cd ~/shm/scripts/rename/

for i in $(ls *.rename.sh | cut -c -5)

do {

	cd ~/shm/processed_data/demultiplex/${i}
	source ~/shm/scripts/rename/${i}.rename.sh

}
done
