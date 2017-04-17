#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o admixture-stdout-%j.txt
#SBATCH -e admixture-stderr-%j.txt
#SBATCH -J tobed

cd ~/shm/results/

sed -i 's/NW_//g' ~/shm/variants/all.bim
sed -i 's/\.1//g' ~/shm/variants/all.bim
cat ~/shm/variants/all.bim |  awk 'BEGIN { OFS = "\t" }{gsub("012","",$1)}1' |  awk 'BEGIN { OFS = "\t" }{gsub("012","",$2)}1' > ~/shm/variants/all.bim.1
mv ~/shm/variants/all.bim.1 ~/shm/variants/all.bim


for K in 2 3 4;

	do ~/bin/admixture_linux-1.23/admixture --cv ~/shm/variants/all.ped $K | tee log${K}.out; 
done

