#!/bin/bash
#SBATCH --job-name=centrifuge
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 10
#SBATCH --partition=general
#SBATCH --qos=general
##SBATCH --mail-type=END
#SBATCH --mem=100G
##SBATCH --mail-user=neranjan.perera@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --array=[0-3]%4

##                                             ##
##########################################################

module purge

date
hostname

DATADIR=(/projects/EBP/CBC/pyxicephalus/data/JMalone-liver/18JUL19_JM_Liver_run2/18JUL19_JM_Liver_run2_1538_PAD75907_LSK109/20190718_1922_2-E3-H3_PAD75907_718f84dd/fastq_pass /projects/EBP/CBC/pyxicephalus/data/JMalone-liver/18JUL19_JM_Liver_run2/18JUL19_JM_Liver_run2_1539_PAD78810_LSK109/20190718_1922_2-E9-H9_PAD78810_c04bdee4/fastq_pass /projects/EBP/CBC/pyxicephalus/data/JMalone-liver/09JUL19_JM_liver_PRO002_LSK109/09JUL19_JM_1538liver_PAD75899_PRO002_LSK109/20190710_1249_2-A1-D1_PAD75899_eb8b26ce/fastq_pass /projects/EBP/CBC/pyxicephalus/data/JMalone-liver/09JUL19_JM_liver_PRO002_LSK109/09JUL19_JM_1539liver_PAD76640_PRO002_LSK109/20190710_1249_2-A7-D7_PAD76640_8cfac641/fastq_pass)

SAMPLE=(18JUL_1538_liver 18JUL_1539_liver 09JUL_1538_liver 09JUL_1539_liver)

sample=${SAMPLE[$SLURM_ARRAY_TASK_ID]}
data_dir=${DATADIR[$SLURM_ARRAY_TASK_ID]}

mkdir -p /projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/03_Centrifuge/${sample}/{fastq_out,centrifuge_out}

cd ${data_dir}

lst=*.fastq

FILENAME=`echo $lst | awk -v OFS="," '$1=$1'`

centifugeOutDir=/projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/03_Centrifuge/${sample}/centrifuge_out
fastq_out=/projects/EBP/CBC/pyxicephalus/Analysis/AnalysisDataOutputDir/03_Centrifuge/${sample}/fastq_out


module load centrifuge/1.0.4-beta

#cd ${centifugeOutDir}

centrifuge \
	-p 10 \
	-x /isg/shared/databases/centrifuge/b+a+v+h/p_compressed+h+v \
	--report-file ${centifugeOutDir}/${sample}_centrifuge_report.tsv \
	--quiet --mm \
	--min-hitlen 50 \
	--un ${fastq_out} \
	-U ${FILENAME} -S ${centifugeOutDir}/${sample}_classification.txt

date

