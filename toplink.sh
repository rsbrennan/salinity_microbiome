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


#all indivs to ped
zcat ~/shm/variants/all.filtered.vcf.gz  |\
vcftools --vcf - \
--plink \
--chrom-map ~/shm/variants/all.plink-chrom-map.txt \
--out all

#thin for ld

~/bin/plink --file all --indep 50 5 2 \
        --allow-extra-chr \
        -out all

for i in fh_fd fh fh.potomac fh.james fh.potomac.admix_J7_remove fh.potomac.admix_remove;
do
	~/bin/plink --file all --indep 50 5 2 \
	--allow-extra-chr \
	--keep ~/shm/scripts/pop.lists/${i}.txt \
	--out ${i}

done

# output thinned ped

for i in fh_fd fh fh.potomac fh.james fh.potomac.admix_J7_remove fh.potomac.admix_remove;
do
	~/bin/plink --file all --extract ${i}.prune.in --recode --allow-extra-chr \
	--keep ~/shm/scripts/pop.lists/${i}.txt \
	--out ${i}.thinned

done


#all indivs
        ~/bin/plink --file all --extract all.prune.in --recode --allow-extra-chr \
        --out all.thinned

