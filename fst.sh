#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o fst-stdout-%j.txt
#SBATCH -e fst-stderr-%j.txt
#SBATCH -J fst

cd ~/shm/analysis/fst

module load vcftools/0.1.13

#1 PP vs PL

for P1 in $(ls ~/shm/processed_data/aligned/all/*.bam | cut -f 8 -d "/" | cut -f 1-2 -d "-" | sort | uniq)
do
for P2 in $(ls ~/shm/processed_data/aligned/all/*.bam | cut -f 8 -d "/" | cut -f 1-2 -d "-" | sort | uniq)
do


cat  ~/shm/scripts/pop.lists/${P1}.indivs  ~/shm/scripts/pop.lists/${P2}.indivs \
        > ~/shm/scripts/pop.lists/${P1}.${P2}.indivs

zcat  ~/shm/variants/all.filtered.vcf.gz |\
sed 's/\.:\.:\.:\.:\.:\.:\./\.\/\.:\.:\.:\.:\.:\.:\./g' |\
vcftools --vcf - \
--keep ~/shm/scripts/pop.lists/${P1}.${P2}.indivs \
--weir-fst-pop ~/shm/scripts/pop.lists/${P1}.indivs \
--weir-fst-pop ~/shm/scripts/pop.lists/${P2}.indivs \
--out ${P1}_vs_${P2}


done
done
