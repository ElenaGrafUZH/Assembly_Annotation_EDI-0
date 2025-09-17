#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="04_fastqc_RNAseq"
#SBATCH --array=1-2  
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --mem=4g
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A_%a.out

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
OUTDIR="${WORKDIR}/4_fastqc_RNAseq"
CONTAINERFASTQC=/containers/apptainer/fastqc-0.12.1.sif

#*----------Input file variables----------
FILES=(
    "${WORKDIR}/3_fastp/ERR754081_1.trimmed.fastq.gz"
    "${WORKDIR}/3_fastp/ERR754081_2.trimmed.fastq.gz"
)

#*----------Select file based on input array----------
INPUT=${FILES[$SLURM_ARRAY_TASK_ID-1]}


#*----------Create output directory----------
mkdir -p ${OUTDIR}

#*----------Run Fastqc with apptainer----------
apptainer exec --bind ${WORKDIR} ${CONTAINERFASTQC} fastqc ${INPUT} -t 1 -o ${OUTDIR}



