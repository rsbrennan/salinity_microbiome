#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/shm/slurm-log/
#SBATCH -o cov.indiv-stdout-%j.txt
#SBATCH -e cov.indiv-stderr-%j.txt
#SBATCH -J cov.indiv

my_bamtools=~/bin/bamtools/bin/bamtools
my_bedtools=~/bin/bedtools2/bin/bedtools
my_samtools=~/bin/samtools-1.3.1/samtools

cd ~/shm/processed_data/aligned/all

for indiv in $( ls *.bam | grep -v '.bai' | cut -f 1 -d "." )

do {

	samtools view -h -b -F 1024 $indiv.bam | samtools view -b -h -F 4 - |\
	bedtools coverage -abam stdin \
	-b ~/breeding/scripts/probes.20pos.bed \
	> ~/shm/summary_files/coverage/$indiv.depth.txt

}
done
