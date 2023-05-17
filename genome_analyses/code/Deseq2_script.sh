#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 4:00:00
#SBATCH -J 08_differential_expression
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se

# Load modules
module load bioinfo-tools R R_packages

input="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/07_counting/results/htseq_result.txt"
raw="/home/nelmak/2_Christel_2017/RNA_raw_data/*"

n=2
for filename in $raw; do
if [[ "$filename" == *"_1"* ]]; then

output=${filename/_1*/}
output=${output##*/}

cut -f 1,$n $input > $input/${output}_counts.txt

((n=n+1))


fi
done

# Define path to R script
script="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/code/R_code_diff_exp.r"

Rscript $script

exit 0
