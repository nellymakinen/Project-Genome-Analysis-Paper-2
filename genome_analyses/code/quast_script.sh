#!/bin/bash -l

#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 1:00:00
#SBATCH -J 01_01_assembly_evaluation_quast
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se

# Load modules
module load bioinfo-tools quast


output_directory="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/02_assembly_evaluation/02_01_assembly_evaluation"

file="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/01_genome_assembly/01_01_assembly_canu.contigs.fasta"

quast.py -o $output_directory $file
