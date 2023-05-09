#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10:00:00
#SBATCH -J 07_counting_reads
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se


# Load modules
module load bioinfo-tools htseq samtools

# Define paths
bam_files="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/06_mapping/results/*.bam"
bai_files="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/06_mapping/results/*.bai"
gff_file="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/03_genome_annotation/PROKKA_04172023_NO_NS.gff"
out="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/07_counting/results/htseq_result.txt"

# Create index for bam files
#for filename in $bam_files; do
#samtools index $filename ${filename/.bam/.bai}
#done

# Run HtSeq
htseq-count -r pos -i ID -s no -t CDS  -f bam $bam_files $gff_file > $out

exit 0
