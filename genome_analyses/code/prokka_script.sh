#!/bin/bash -l

#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH --mail-user nelly.makinen.3552@student.uu.se
#SBATCH --mail-type=ALL

# Load modules

module load bioinfo-tools
module load prokka

# Specify output directory and input file

output="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/03_genome_annotation/"
file_name="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/01_genome_assembly/01_01_assembly_canu.contigs.fasta"

# Run the prokka software
prokka --outdir $output --force $file_name

exit 0
