#!/bin/bash
#SBATCH --job-name=NanoPlot
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 10
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=END
#SBATCH --mem=40G
#SBATCH --mail-user=neranjan.perera@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --array=[0-3]%4

##                                             ##
##########################################################

module purge

date
hostname

DATADIR=(/projects/EBP/CBC/pyxicephalus/data/JMalone-liver/18JUL19_JM_Liver_run2/18JUL19_JM_Liver_run2_1538_PAD75907_LSK109/20190718_1922_2-E3-H3_PAD75907_718f84dd/ /projects/EBP/CBC/pyxicephalus/data/JMalone-liver/18JUL19_JM_Liver_run2/18JUL19_JM_Liver_run2_1539_PAD78810_LSK109/20190718_1922_2-E9-H9_PAD78810_c04bdee4/ /projects/EBP/CBC/pyxicephalus/data/JMalone-liver/09JUL19_JM_liver_PRO002_LSK109/09JUL19_JM_1538liver_PAD75899_PRO002_LSK109/20190710_1249_2-A1-D1_PAD75899_eb8b26ce/ /projects/EBP/CBC/pyxicephalus/data/JMalone-liver/09JUL19_JM_liver_PRO002_LSK109/09JUL19_JM_1539liver_PAD76640_PRO002_LSK109/20190710_1249_2-A7-D7_PAD76640_8cfac641/)

SAMPLE=(18JUL_1538_liver 18JUL_1539_liver 09JUL_1538_liver 09JUL_1539_liver)

sample=${SAMPLE[$SLURM_ARRAY_TASK_ID]}
data_dir=${DATADIR[$SLURM_ARRAY_TASK_ID]}

mkdir -p /projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/NanoPlot/${sample}/

NanoPlotOutDir=/projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/NanoPlot/${sample}


module load NanoPlot/1.21.0

cd ${NanoPlotOutDir}

NanoPlot --summary ${data_dir}/*sequencing_summary.txt \
	--loglength \
	-o summary-plots-log-transformed \
	--N50 --title ${sample} \
	-t 10

date

