#!/bin/bash
#SBATCH --job-name=NanoFilt
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 10
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mem=50G
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

mkdir -p /projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/05_NanoPlot/${sample}/

NanoPlotOutDir=/projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/05_NanoPlot/${sample}

module load NanoPlot/1.21.0

cd ${NanoPlotOutDir}

NanoPlot --fastq /projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/04_NanoFilt/${sample}_filteredReads.fastq \
        --loglength \
        -o summary-plots-log-transformed \
        --N50 --title ${sample} \
        -t 10

date
