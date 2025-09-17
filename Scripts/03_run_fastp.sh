#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="03_fastp"
#SBATCH --array=1-2
#SBATCH --mail-type=FAIL
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --mem=16g
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A_%a.out

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
OUTDIR="${WORKDIR}/3_fastp"
CONTAINERFASTP=/containers/apptainer/fastp_0.23.2--h5f740d0_3.sif

mkdir -p ${OUTDIR}

#*----------Select sample----------
if [ "$SLURM_ARRAY_TASK_ID" -eq 1 ]; then
    # Edi-0 single-end
    READ1="${WORKDIR}/Data/Edi-0/ERR11437331.fastq.gz"
    SAMPLE="ERR11437331"

    apptainer exec --bind ${WORKDIR} ${CONTAINERFASTP} fastp \
    -i $READ1 \
    -o $OUTDIR/${SAMPLE}.fastq.gz \
    --disable_length_filtering \
    --disable_quality_filtering \
    --disable_adapter_trimming \
    -h $OUTDIR/fastp_${SAMPLE}.html \
    -j $OUTDIR/fastp_${SAMPLE}.json \
    -R "fastp report for $SAMPLE (HiFi)"

elif [ "$SLURM_ARRAY_TASK_ID" -eq 2 ]; then
    # RNA-seq Sha paired-end
    READ1="${WORKDIR}/Data/RNAseq_Sha/ERR754081_1.fastq.gz"
    READ2="${WORKDIR}/Data/RNAseq_Sha/ERR754081_2.fastq.gz"
    SAMPLE="ERR754081"

    apptainer exec --bind ${WORKDIR} ${CONTAINERFASTP} fastp \
        -i ${READ1} -I ${READ2} \
        -o "${OUTDIR}/${SAMPLE}_1.trimmed.fastq.gz" \
        -O "${OUTDIR}/${SAMPLE}_2.trimmed.fastq.gz" \
        --detect_adapter_for_pe \
        --trim_poly_x \
        --cut_tail \
        --cut_window_size 4 \
        --cut_mean_quality 20 \
        -h "${OUTDIR}/fastp_${SAMPLE}.html" \
        -j "${OUTDIR}/fastp_${SAMPLE}.json" \
        -R "fastp_${SAMPLE} Report"
fi
