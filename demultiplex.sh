#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsbrennan@ucdavis.edu
#SBATCH -D /home/rsbrenna/breeding/slurm-log/
#SBATCH -o demultiplex-stdout-%j.txt
#SBATCH -e demultiplex-stderr-%j.txt
#SBATCH -J demultiplex


cd ~/shm/rawdata/

for i in $(ls *.fastq.gz | grep -v 'Undetermined' | cut -c -15 | uniq )

do {

	lib=$(echo $i |cut -f 1 -d "_")
	echo $i
	echo $lib
	mkdir ~/shm/processed_data/demultiplex/${lib}
	perl /home/rsbrenna/scripts/BarcodeSplitListBestRadPairedEnd.pl \
	~/shm/rawdata/${i}_R1_001.fastq.gz \
	~/shm/rawdata/${i}_R2_001.fastq.gz GGACAAGCTA,GGAAACATCG,GGACATTGGC,GGACCACTGT,GGAACGTGAT,GGCGCTGATC,GGCAGATCTG,GGATGCCTAA,GGAACGAACG,GGAGTACAAG,GGCATCAAGT,GGAGTGGTCA,GGAACAACCA,GGAACCGAGA,GGAACGCTTA,GGAAGACGGA,GGAAGGTACA,GGACACAGAA,GGACAGCAGA,GGACCTCCAA,GGACGCTCGA,GGACGTATCA,GGACTATGCA,GGAGAGTCAA,GGAGATCGCA,GGAGCAGGAA,GGAGTCACTA,GGATCCTGTA,GGATTGAGGA,GGCAACCACA,GGCAAGACTA,GGCAATGGAA,GGCACTTCGA,GGCAGCGTTA,GGCATACCAA,GGCCAGTTCA,GGCCGAAGTA,GGCCGTGAGA,GGCCTCCTGA,GGCGAACTTA,GGCGACTGGA,GGCGCATACA,GGCTCAATGA,GGCTGAGCCA,GGCTGGCATA,GGGAATCTGA,GGGACTAGTA,GGGAGCTGAA,GGGATAGACA,GGGCCACATA,GGGCGAGTAA,GGGCTAACGA,GGGCTCGGTA,GGGGAGAACA,GGGGTGCGAA,GGGTACGCAA,GGGTCGTAGA,GGGTCTGTCA,GGGTGTTCTA,GGTAGGATGA,GGTATCAGCA,GGTCCGTCTA,GGTCTTCACA,GGTGAAGAGA,GGTGGAACAA,GGTGGCTTCA,GGTGGTGGTA,GGTTCACGCA,GGACACGAGA,GGAAGAGATC,GGAAGGACAC,GGAATCCGTC,GGAATGTTGC,GGACACTGAC,GGACAGATTC,GGAGATGTAC,GGAGCACCTC,GGAGCCATGC,GGAGGCTAAC,GGATAGCGAC,GGACGACAAG,GGATTGGCTC,GGCAAGGAGC,GGCACCTTAC,GGCCATCCTC,GGCCGACAAC,GGAGTCAAGC,GGCCTCTATC,GGCGACACAC,GGCGGATTGC,GGCTAAGGTC,GGGAACAGGC,GGGACAGTGC,GGGAGTTAGC,GGGATGAATC,GGGCCAAGAC \
	~/shm/processed_data/demultiplex/${lib}/

}

done
