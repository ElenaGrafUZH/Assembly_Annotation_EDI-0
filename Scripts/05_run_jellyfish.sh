#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="05_run_jellyfish"
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=4
#SBATCH --time=02:00:00
#SBATCH --mem=40G
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A_%a.out

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
OUTDIR="${WORKDIR}/5_jellyfish"
READ="${WORKDIR}/Data/Edi-0/ERR11437331.fastq.gz"


#*----------Create output directory----------
mkdir -p ${OUTDIR}

#*----------Load modules----------
module load Jellyfish/2.3.0-GCC-10.3.0

#*----------Run Jellyfish----------

jellyfish count -C -m 21 -s 5G -t 4 \
  <(zcat ${READ}) -o ${OUTDIR}/reads.jf
  
jellyfish histo -t 4 "${OUTDIR}/reads.jf" > "${OUTDIR}/reads.histo"

