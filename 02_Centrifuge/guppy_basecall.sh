#!/bin/bash
#SBATCH --job-name=guppy_basecaller
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --mem=100G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=[0-3]%4
hostname
date

##########################################################
##              Guppy                                   ##
##########################################################

DATADIR=(/projects/EBP/CBC/pyxicephalus/data/JMalone-liver/18JUL19_JM_Liver_run2/18JUL19_JM_Liver_run2_1538_PAD75907_LSK109/20190718_1922_2-E3-H3_PAD75907_718f84dd/fast5_pass /projects/EBP/CBC/pyxicephalus/data/JMalone-liver/18JUL19_JM_Liver_run2/18JUL19_JM_Liver_run2_1539_PAD78810_LSK109/20190718_1922_2-E9-H9_PAD78810_c04bdee4/fast5_pass /projects/EBP/CBC/pyxicephalus/data/JMalone-liver/09JUL19_JM_liver_PRO002_LSK109/09JUL19_JM_1538liver_PAD75899_PRO002_LSK109/20190710_1249_2-A1-D1_PAD75899_eb8b26ce/fast5_pass /projects/EBP/CBC/pyxicephalus/data/JMalone-liver/09JUL19_JM_liver_PRO002_LSK109/09JUL19_JM_1539liver_PAD76640_PRO002_LSK109/20190710_1249_2-A7-D7_PAD76640_8cfac641/fast5_pass)

OUTDIR=(18JUL_1538 18JUL_1539 09JUL_1538 09JUL_1539)

#FLOWCELL=(PAD75907 PAD78810 PAD75899 PAD76640)

#KIT=(SQK-LSK109 SQK-LSK109 SQK-LSK109 SQK-LSK109)

data_dir=${DATADIR[$SLURM_ARRAY_TASK_ID]}
flow_cell=${FLOWCELL[$SLURM_ARRAY_TASK_ID]}
kit_Val=${KIT[$SLURM_ARRAY_TASK_ID]}
out_dir=${OUTDIR[$SLURM_ARRAY_TASK_ID]}

mkdir -p ./${out_dir}/{log,fastq}

cd ./${out_dir}/log

module load guppy/3.4.5


echo -e "${out_dir} \n ${data_dir} \n ${flow_cell} \n ${kit_Val}"


guppy_basecaller \
        -i ${data_dir} \
        -s ./${out_dir}/fastq \
        --flowcell FLO-PRO002 \
        --kit SQK-LSK109 \
        --qscore_filtering \
        --cpu_threads_per_caller 16

date
