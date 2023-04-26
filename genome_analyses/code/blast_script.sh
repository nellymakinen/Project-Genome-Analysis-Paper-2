#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 1:0:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se

# Load modules
module load bioinfo-tools blast

genome="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/01_genome_assembly/01_01_assembly_canu.contigs.fasta"
reference="/home/nelmak/2_Christel_2017/reference/OBMB01.fasta"
output_dir="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/04_blast_comparison"

blastn -task blastn -query $genome -subject $reference -outfmt 6 > $output_dir/comparison.crunch
