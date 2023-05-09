#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 2:00:00
#SBATCH -J 09_RNA_trimmed
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se

# Load modules
module load bioinfo-tools FastQC

# Define paths
data="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/05_trimming/results/*"
output="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/09_RNA_quality/trimmed"

# Run fastqc
fastqc -t 2 $data -o $output 

exit 0
