#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o tobed-stdout-%j.txt
#SBATCH -e tobed-stderr-%j.txt
#SBATCH -J tobed

cd ~/shm/variants/

~/bin/plink --file all --extract all.prune.in --make-bed --allow-extra-chr \
--out all
