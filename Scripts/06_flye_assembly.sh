#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="06_flye_assembly"
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=16
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A.out

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
OUTDIR="${WORKDIR}/6_flye_hifi"
CONTAINERFLYE=/containers/apptainer/flye_2.9.5.sif
READ="${WORKDIR}/Data/Edi-0/ERR11437331.fastq.gz"


#*----------Create output directory----------
mkdir -p ${OUTDIR}


#*----------Run Flye----------
apptainer exec --bind ${WORKDIR} ${CONTAINERFLYE} flye --pacbio-hifi ${READ} --out-dir ${OUTDIR} --threads ${SLURM_CPUS_PER_TASK}

