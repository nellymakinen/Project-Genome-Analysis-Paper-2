#!/bin/bash -l

#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 1:00:00
#SBATCH -J 05_trimming
#SBATCH -o trimming.output
#SBATCH -e trimming.output
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se

# Load modules
module load bioinfo-tools
module load trimmomatic/0.36

code="/home/nelmak/Project-Genome-Analysis-Paper-2/genome_analyses/analyses/05_trimming/"

data="/home/nelmak/2_Christel_2017/RNA_raw_data/"

adapter="$TRIMMOMATIC_HOME/adapters/TruSeq2-PE.fa"

for filename in $data*; do

if [[ "$filename" == *"_1"* ]]; then

forward_file=$filename	
reverse_file=${filename/_1/_2}

sample_file=${filename/$data/}
sample_name=${sample_file/_1*/}

trimmomatic PE -phred33 $forward_file $reverse_file \
"${code}"results/"${sample_file/_1/_1P}" "${code}"results/"${sample_file/_1/_1U}" "${code}"results/"${sample_file/_1/_2P}" "${code}"results/"${sample_file/_1/_2U}" \
ILLUMINACLIP:$adapter_path:2:30:10 \
SLIDINGWINDOW:4:15 \
LEADING:3 TRAILING:3 MINLEN:40 MAXINFO:40:0.5

fi

done

exit 0
