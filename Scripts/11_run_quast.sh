#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="11_run_quast"
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=64
#SBATCH --time=1-00:00:00
#SBATCH --mem=200G
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A_%a.out

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
CONTAINERQUAST=/containers/apptainer/quast_5.2.0.sif

#output directories
OUTDIR="${WORKDIR}/11_1_quast"
OUTDIR_NOREF="${OUTDIR}/no_reference"
OUTDIR_REF="${OUTDIR}/with_reference"

#fasta files
FLYEASSEMBLY="${WORKDIR}/Data/Assemblies/flye_hifi_assembly.fasta"
HIFIASMASSEMBLY="${WORKDIR}/Data/Assemblies/hifiasm_Edi-0.asm.bp.p_ctg.fa"
LJAASSEMBLY="${WORKDIR}/Data/Assemblies/lja_assembly.fasta"

#reference genome
REF_GENOME="${REF_DIR}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"


#*----------Input file variables----------
FILES=(
    $FLYEASSEMBLY
    $HIFIASMASSEMBLY
    $LJAASSEMBLY

)
#*----------Tools variables----------
TOOLS="flye,hifiasm,lja"


#*----------Create output directories----------
mkdir -p ${OUTDIR_NOREF}
mkdir -p ${OUTDIR_REF}



#*----------Run QUAST without reference----------
echo "Running QUAST without reference..."
apptainer exec --bind ${WORKDIR} ${CONTAINERQUAST} quast.py \
    --eukaryote \
    --est-ref-size 135000000 \
    --labels ${TOOLS} \
    --threads ${SLURM_CPUS_PER_TASK} \
    "${FILES[@]}" \
    -o "${OUTDIR_NOREF}"

#*----------Check QUAST without reference status----------
if [[ $? -eq 0 ]]; then
    echo "QUAST quality assessment without reference completed successfully for ${TOOLS}; ${FILES}"
else
    echo "QUAST quality assessment without referencefailed for ${TOOLS}; ${FILES}"
    exit 1
fi


#*----------Run QUAST with reference----------
echo "Running QUAST with reference..."
apptainer exec --bind ${WORKDIR} ${CONTAINERQUAST} quast.py \
    --eukaryote \
    --labels ${TOOLS} \
    -r ${REF_GENOME} \
    --features ${REF_ANNOT} \
    --threads ${SLURM_CPUS_PER_TASK} \
    "${FILES[@]}" \
    -o ${OUTDIR_REF}

#*----------Check QUAST with reference status----------
if [[ $? -eq 0 ]]; then
    echo "QUAST quality assessment with reference completed successfully for ${TOOLS}; ${FILES}"
else
    echo "QUAST quality assessment with referencefailed for ${TOOLS}; ${FILES}"
    exit 1
fi