#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="07_hifiasm_assembly"
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=64
#SBATCH --time=3-00:00:00
#SBATCH --mem=200G
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A.out

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
OUTDIR="${WORKDIR}/7_hifiasm"
CONTAINERHIFIASM=/containers/apptainer/hifiasm_0.25.0.sif
READ="${WORKDIR}/Data/Edi-0/ERR11437331.fastq.gz"


#*----------Create output directory----------
mkdir -p ${OUTDIR}


#*----------Run Hifiasm----------
apptainer exec --bind ${WORKDIR} ${CONTAINERHIFIASM} hifiasm -o "${OUTDIR}/Edi-0.asm" -t ${SLURM_CPUS_PER_TASK} ${READ}


#*----------Check hifiasm status----------
if [[ $? -eq 0 ]]; then
    echo "hifiasm assembly completed successfully for ${READ}"
else
    echo "hifiasm assembly failed for ${READ}"
    exit 1
fi

#*----------Convert GFA files to FASTA----------
awk '/^S/{print ">"$2;print $3}' "${OUTDIR}/Edi-0.asm.bp.p_ctg.gfa" > "${OUTDIR}/Edi-0.asm.bp.p_ctg.fa"

#*----------Check conversion status----------
if [[ $? -eq 0 ]]; then
    echo "FASTA conversion completed successfully"
    echo "Final assembly: ${OUTDIR}/Edi-0.asm.bp.p_ctg.fa"
else
    echo "FASTA conversion failed"
    exit 1
fi