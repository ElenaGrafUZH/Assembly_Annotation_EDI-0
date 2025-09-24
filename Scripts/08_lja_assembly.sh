#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="08_lja_assembly"
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=64
#SBATCH --time=3-00:00:00
#SBATCH --mem=200G
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A.out

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
OUTDIR="${WORKDIR}/8_lja"
CONTAINERLJA=/containers/apptainer/lja-0.2.sif
READ="${WORKDIR}/Data/Edi-0/ERR11437331.fastq.gz"


#*----------Create output directory----------
mkdir -p ${OUTDIR}


#*----------Run LJA----------
apptainer exec --bind ${WORKDIR} ${CONTAINERLJA} lja -o ${OUTDIR} --reads ${READ} -t ${SLURM_CPUS_PER_TASK}


#*----------Check lja status----------
if [[ $? -eq 0 ]]; then
    echo "lja assembly completed successfully for ${READ}"
else
    echo "lja assembly failed for ${READ}"
    exit 1
fi