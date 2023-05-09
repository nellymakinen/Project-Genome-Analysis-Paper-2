#!/bin/bash -l

#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 4:00:00
#SBATCH -J 06_mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se

# Load modules
module load bioinfo-tools bwa samtools

# Define paths
data="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/05_trimming/results/"
output="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/06_mapping/results/"
genome="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/01_genome_assembly/01_01_assembly_canu.contigs.fasta"

for filename in $data*; do

if [[ "$filename" == *"1P"* ]]; then

left_read=$filename
right_read=${filename/1P/2P}

file_id=${filename/$data/}
file_id=${file_id/.fastq.gz/}

bwa index $genome
bwa mem -t 4 $genome $left_read $right_read | samtools sort -@ 4 -o $output/${file_id}.bam

fi
done

exit 0
