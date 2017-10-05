#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o admixture-stdout-%j.txt
#SBATCH -e admixture-stderr-%j.txt
#SBATCH -J admixture

cd ~/shm/variants/

#there are issues with how the scaffolds are named.
#changing them to numbers with a reference table.

zcat ~/shm/variants/all.vcf.gz | grep -v '^#' | \
cut -f 1 | sort | uniq > ~/shm/scripts/scaffold.list

touch ~/shm/scripts/scaffold.num

for i in {1..621}
do
 echo $i >> ~/shm/scripts/scaffold.num
done

paste ~/shm/scripts/scaffold.list scaffold.num > scaffold.table

for i in fh.potomac fh.james fh.james.j7_remove fh.potomac.admix_J7_remove;
do
	awk 'NR==1 { next } FNR==NR { a[$1]=$2; next } $1 in a { $1=a[$1] }1' \
	~/shm/scripts/scaffold.table ~/shm/variants/${i}.bim | \
	awk 'BEGIN { OFS = " " }{gsub("NW_012224401.1","1",$1)}1' \
	> ~/shm/variants/${i}.bim.1

	mv ~/shm/variants/${i}.bim.1 ~/shm/variants/${i}.bim

done

# f het alone:

	awk 'NR==1 { next } FNR==NR { a[$1]=$2; next } $1 in a { $1=a[$1] }1' \
	~/shm/scripts/scaffold.table ~/shm/variants/fh.bim | \
	awk 'BEGIN { OFS = " " }{gsub("NW_012224401.1","1",$1)}1' \
		> ~/shm/variants/fh.bim.1

	mv ~/shm/variants/fh.bim.1 ~/shm/variants/fh.bim


cd ~/shm/analysis/admixture

#run admixture

for i in fh.potomac fh.james fh.james.j7_remove fh.potomac.admix_J7_remove;
do
	for K in 2 3 4;

	do ~/bin/admixture_linux-1.23/admixture --cv \
	~/shm/variants/${i}.bed $K | tee log.${i}.${K}.out;
done
done


## admixture, fhet alone

for K in 2 3 4; do

	~/bin/admixture_linux-1.23/admixture --cv \
	~/shm/variants/fh.bed $K | tee log.fh.${K}.out;

done

