#!/bin/bash -l

#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 15:00:00
#SBATCH -J 01_01_assembly_canu
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se

# Load modules
module load bioinfo-tools
module load canu/2.0

# Assembly
canu \
-p 01_01_assembly_canu \
-d /home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/01_genome_assembly \
genomeSize=2.4m \
-useGrid=false -maxThreads=4 \
-pacbio \
/home/nelmak/2_Christel_2017/DNA_raw_data/*

exit 0
