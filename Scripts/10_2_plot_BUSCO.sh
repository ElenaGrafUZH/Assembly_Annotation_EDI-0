#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="10_2_plot_busco"
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=16
#SBATCH --time=1-00:00:00
#SBATCH --mem=200G
#SBATCH --partition=pibu_el8
#SBATCH --output=./Job_log/slurm_busco_plot_%A.out
#SBATCH --error=./Job_log_errors/error_busco_plot_%A.e

#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
OUTDIR="${WORKDIR}/10_2_busco_plots"

#busco output files
BUSCO_FLYE="${WORKDIR}/10_busco/BUSCO_flye/short_summary.specific.brassicales_odb10.BUSCO_flye.txt"
BUSCO_HIFIASM="${WORKDIR}/10_busco/BUSCO_hifiasm/short_summary.specific.brassicales_odb10.BUSCO_hifiasm.txt"
BUSCO_LJA="${WORKDIR}/10_busco/BUSCO_lja/short_summary.specific.brassicales_odb10.BUSCO_lja.txt"
BUSCO_TRINITY="${WORKDIR}/10_busco/BUSCO_trinity/short_summary.specific.brassicales_odb10.BUSCO_trinity.txt"

#*----------Load modules----------
module load BUSCO/5.4.2-foss-2021a

#*----------Create output directory----------
mkdir -p ${OUTDIR}
cd ${OUTDIR}

#copy busco files to outdir and rename
cp "${BUSCO_FLYE}" "short_summary.specific.brassicales_odb10.flye.txt"
cp "${BUSCO_HIFIASM}" "short_summary.specific.brassicales_odb10.hifiasm.txt"
cp "${BUSCO_LJA}" "short_summary.specific.brassicales_odb10.lja.txt"
cp "${BUSCO_TRINITY}" "short_summary.specific.brassicales_odb10.trinity.txt"

# Download the generate_plot.py script from GitLab 
wget -O generate_plot.py "https://gitlab.com/ezlab/busco/-/raw/5.4.2/scripts/generate_plot.py"

# Check if download was successful
if [ ! -f "generate_plot.py" ]; then
    echo "Error: Failed to download generate_plot.py"
    exit 1
fi

#*----------Run Plot generations----------
python3 generate_plot.py -wd "${OUTDIR}"