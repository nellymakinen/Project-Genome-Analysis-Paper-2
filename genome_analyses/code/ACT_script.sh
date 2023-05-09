#!/bin/bash -l

#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 4:00:00
#SBATCH -J artemis
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se

# Load modules
module load bioinfo-tools artemis

# Define files
comparison_file="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/04_blast_comparison/comparison.crunch"

main="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/01_genome_assembly/*contigs.fasta"

reference="/home/nelmak/2_Christel_2017/reference/OBM01.fasta"

output="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/04_blast_comparison/artemis"

# Run artemis
echo "act $main $comparison_file $reference"
act $main $comparison_file $reference > $output

exit 0
