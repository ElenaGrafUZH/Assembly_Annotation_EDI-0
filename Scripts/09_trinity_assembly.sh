#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="09_trinity_assembly"
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=16
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A.out

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
OUTDIR="${WORKDIR}/9_trinity"
READ1="${WORKDIR}/Data/RNAseq_Sha/ERR754081_1.fastq.gz"
READ2="${WORKDIR}/Data/RNAseq_Sha/ERR754081_2.fastq.gz"


#*----------Create output directory----------
mkdir -p ${OUTDIR}


#*----------Load modules----------
module load Trinity/2.15.1-foss-2021a


#*----------Run Trinity----------
Trinity --seqType fq --left ${READ1} --right ${READ2} --CPU ${SLURM_CPUS_PER_TASK} --max_memory 60G --output ${OUTDIR}


#*----------Check Trinity status----------
if [[ $? -eq 0 ]]; then
    echo "Trinity assembly completed successfully for ${READ1} and ${READ2}"
else
    echo "Trinity assembly failed for ${READ1} and ${READ2}"
    exit 1
fi