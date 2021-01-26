#!/bin/bash
#SBATCH --job-name=NanoFilt
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --partition=general
#SBATCH --qos=general
##SBATCH --mail-type=END
#SBATCH --mem=10G
##SBATCH --mail-user=neranjan.perera@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --array=[0-3]%4

##                                             ##
##########################################################

module purge

date
hostname


SAMPLE=(18JUL_1538_liver 18JUL_1539_liver 09JUL_1538_liver 09JUL_1539_liver)

sample=${SAMPLE[$SLURM_ARRAY_TASK_ID]}

mkdir -p /projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/04_NanoFilt/

echo "Sample under processing "${sample}

module load nanofilt/2.6.0

INPUTFILE=/projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/03_Centrifuge/${sample}/fastq_out/un-seqs
mv ${INPUTFILE} ${INPUTFILE}.fastq

cd /projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/04_NanoFilt/

NanoFilt -l 500 -q 10 ${INPUTFILE}.fastq > ${sample}_filteredReads.fastq 

date

