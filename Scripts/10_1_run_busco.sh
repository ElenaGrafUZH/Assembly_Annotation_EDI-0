#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="10_run_busco"
#SBATCH --array=1-4  
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=16
#SBATCH --time=1-00:00:00
#SBATCH --mem=200G
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A_%a.out

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
OUTDIR="${WORKDIR}/10_busco"
FLYEASSEMBLY="${WORKDIR}/Data/Assemblies/flye_hifi_assembly.fasta"
HIFIASMASSEMBLY="${WORKDIR}/Data/Assemblies/hifiasm_Edi-0.asm.bp.p_ctg.fa"
LJAASSEMBLY="${WORKDIR}/Data/Assemblies/lja_assembly.fasta"
TRINITYASSEMBLY="${WORKDIR}/Data/Assemblies/Trinity.fasta"

#*----------Input file variables----------
FILES=(
    $FLYEASSEMBLY
    $HIFIASMASSEMBLY
    $LJAASSEMBLY
    $TRINITYASSEMBLY
)
#*----------Tools variables----------
TOOLS=(
    "flye"
    "hifiasm"
    "lja"
    "trinity"
)


#*----------Select file based on input array----------
INPUTFILE=${FILES[$SLURM_ARRAY_TASK_ID-1]}

#*----------Select tool based on input array----------
TOOL=${TOOLS[$SLURM_ARRAY_TASK_ID-1]}
#*----------Create output directory----------
mkdir -p ${OUTDIR}



#*----------Load modules----------
module load BUSCO/5.4.2-foss-2021a


#*----------Run BUSCO----------
busco -i ${INPUTFILE} -m genome \
     --lineage_dataset brassicales_odb10 \
     --cpu ${SLURM_CPUS_PER_TASK} \
     --out "BUSCO_${TOOL}" \
     --out_path "${OUTDIR}"

#*----------Check BUSCO status----------
if [[ $? -eq 0 ]]; then
    echo "BUSCO quality assessment completed successfully for ${TOOL}; ${INPUTFILE}"
else
    echo "BUSCO quality assessment failed for ${TOOL}; ${INPUTFILE}"
    exit 1
fi