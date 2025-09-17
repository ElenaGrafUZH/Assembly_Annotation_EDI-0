#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="02_fastqc"
#SBATCH --array=1-3   
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --mem=4g
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A.out

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
OUTDIR="${WORKDIR}/2_fastqc"
CONTAINERFASTQC=/containers/apptainer/fastqc-0.12.1.sif

#*----------Input file variables----------
FILES=(
    "${WORKDIR}/Data/Edi-0/ERR11437331.fastq.gz"
    "${WORKDIR}/Data/RNAseq_Sha/ERR754081_1.fastq.gz"
    "${WORKDIR}/Data/RNAseq_Sha/ERR754081_2.fastq.gz"
)

#*----------Select file based on input array----------
INPUT=${FILES[$SLURM_ARRAY_TASK_ID-1]}


#*----------Create output directory----------
mkdir -p ${OUTDIR}

#*----------Run Fastqc with apptainer----------
apptainer exec --bind ${WORKDIR} ${CONTAINERFASTQC} fastqc ${INPUT} -t 1 -o ${OUTDIR}



