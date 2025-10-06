#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="13_run_nucmer_mummer"
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=16
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --partition=pibu_el8
#SBATCH --output=./Job_log/slurm_nucmer_mummer_%A.out
#SBATCH --error=./Job_log_errors/error_nucmer_mummer_%A.e


#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
CONTAINERMUMMER=/containers/apptainer/mummer4_gnuplot.sif

#output directories
OUTDIR="${WORKDIR}/13_comparing_genomes"

#fasta files
FLYEASSEMBLY="${WORKDIR}/Data/Assemblies/flye_hifi_assembly.fasta"
HIFIASMASSEMBLY="${WORKDIR}/Data/Assemblies/hifiasm_Edi-0.asm.bp.p_ctg.fa"
LJAASSEMBLY="${WORKDIR}/Data/Assemblies/lja_assembly.fasta"

#reference genome
REF_DIR="/data/courses/assembly-annotation-course/references"
REF_GENOME="${REF_DIR}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
REF_ANNOT="${REF_DIR}/Arabidopsis_thaliana.TAIR10.57.gff3"


#*----------Input file variables----------
ASSEMBLIES=(
    $FLYEASSEMBLY
    $HIFIASMASSEMBLY
    $LJAASSEMBLY

)
#*----------Tools variables----------
TOOLS=(
    "flye"
    "hifiasm"
    "lja"

)


#*----------Create output directories----------
mkdir -p "${OUTDIR}"


#*----------Run nucmer----------
##*---------Assemblies against Reference---------
for i in "${!ASSEMBLIES[@]}"; do
    ASSEMBLY="${ASSEMBLIES[i]}"
    TOOL="${TOOLS[i]}"

    echo "Running nucmer for ${TOOL}"

    apptainer exec --bind "${WORKDIR}" "${CONTAINERMUMMER}" \
        nucmer \
        --threads ${SLURM_CPUS_PER_TASK} \
        --mincluster 1000 \
        --breaklen 1000 \
        --prefix "${OUTDIR}/${TOOL}_vs_ref" \
        "${REF_GENOME}" "${ASSEMBLY}"
    
    echo "nucmer completed: ${TOOL}_vs_ref"
done


##*---------Assemblies against each other---------
for i in "${!ASSEMBLIES[@]}"; do
    for j in "${!ASSEMBLIES[@]}"; do
        if [[ $i -lt $j ]]; then
            ASSEMBLY1="${ASSEMBLIES[i]}"
            TOOL1="${TOOLS[i]}"
            ASSEMBLY2="${ASSEMBLIES[j]}"
            TOOL2="${TOOLS[j]}"
            PREFIX="${OUTDIR}/${TOOL1}_vs_${TOOL2}"

            echo "Running nucmer for ${TOOL1} vs ${TOOL2}"

            apptainer exec --bind "${WORKDIR}" "${CONTAINERMUMMER}" \
                nucmer \
                --threads ${SLURM_CPUS_PER_TASK} \
                --mincluster 1000 \
                --breaklen 1000 \
                --prefix "${PREFIX}" \
                "${ASSEMBLY1}" "${ASSEMBLY2}"
            
            echo "nucmer completed: ${TOOL1}_vs_${TOOL2}"
        fi
    done
done

#*----------Run mummer----------
##*---------Plot Assemblies against Reference---------

for i in "${!ASSEMBLIES[@]}"; do
    ASSEMBLY="${ASSEMBLIES[i]}"
    TOOL="${TOOLS[i]}"
    DELTA_FILE="${OUTDIR}/${TOOL}_vs_ref.delta"
    PLOT_PREFIX="${OUTDIR}/${TOOL}_vs_ref_plot"

    echo "Creating plot: ${TOOL} vs reference..."

    apptainer exec --bind "${WORKDIR}" "${CONTAINERMUMMER}" \
        mummerplot \
        -R "${REF_GENOME}" \
        -Q "${ASSEMBLY}" \
        --filter \
        -t png \
        --large \
        --layout \
        --fat \
        -p "${PLOT_PREFIX}" \
        "${DELTA_FILE}"
    
    echo "plot created: ${TOOL}_vs_ref_plot"
done

##*---------Plot Assembly against Assembly---------
for i in "${!ASSEMBLIES[@]}"; do
    for j in "${!ASSEMBLIES[@]}"; do
        if [[ $i -lt $j ]]; then
            ASSEMBLY1="${ASSEMBLIES[i]}"
            TOOL1="${TOOLS[i]}"
            ASSEMBLY2="${ASSEMBLIES[j]}"
            TOOL2="${TOOLS[j]}"
            PREFIX="${OUTDIR}/${TOOL1}_vs_${TOOL2}"
            DELTA_FILE="${OUTDIR}/${TOOL1}_vs_${TOOL2}.delta"
            PLOT_PREFIX="${OUTDIR}/${TOOL1}_vs_${TOOL2}_plot"


            echo "Creating plot: ${TOOL1} vs ${TOOL2}..."

            apptainer exec --bind "${WORKDIR}" "${CONTAINERMUMMER}" \
                mummerplot \
                -R "${ASSEMBLY1}" \
                -Q "${ASSEMBLY2}" \
                --filter \
                -t png \
                --large \
                --layout \
                --fat \
                -p "${PLOT_PREFIX}" \
                "${DELTA_FILE}"
            
            echo "plot created: ${TOOL1}_vs_${TOOL2}_plot"
        fi
    done
done




