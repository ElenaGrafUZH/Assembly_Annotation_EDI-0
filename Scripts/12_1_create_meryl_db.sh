#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="12_create_merylDB"
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=16
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A.out
#SBATCH --error=./Job_log_errors/error_meryl_%A.e


#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
CONTAINERMERQURY=/containers/apptainer/merqury_1.3.sif

#output directories
OUTDIR="${WORKDIR}/12_merqury"
DBDIR="$OUTDIR/meryl_db"
READ_DB="$DBDIR/hifi.meryl"

#hifi reads
READS="${WORKDIR}/Data/Edi-0/ERR11437331.fastq.gz"

#genome size
GENOMESIZE=135000000

#*----------Path Variable----------
export MERQURY="/usr/local/share/merqury"

mkdir -p "$DBDIR"

#*----------Check if all files are there----------
[[ -s "$READS" ]] || { echo "Missing HiFi reads: $READS" >&2; exit 1; }

#*---------- Step 1: determine best k ----------
if [ ! -f $OUTDIR/best_k.txt ]; then
    echo "Finding best k for genome size ${GENOMESIZE}..."
    K=$(apptainer exec --bind ${WORKDIR} ${CONTAINERMERQURY} sh $MERQURY/best_k.sh ${GENOMESIZE} 0.001 | tail -n1)
    echo $K > best_k.txt
else
    K=$(cat best_k.txt)
fi

echo "Using k=${K}"
#*---------- Step 2: build meryl DB ----------
echo "===> Building/using meryl DB: $READ_DB (k=$K)"
if [ ! -s "$READ_DB/merylIndex" ]; then
  apptainer exec --bind /data:/data "$CONTAINERMERQURY" \
    meryl count k=$K output "$READ_DB" "$READS"
fi


#*----------Check merqury status----------
if [[ $? -eq 0 ]]; then
    echo "meryl db creation completed successfully"
else
    echo "meryl db failed"
    exit 1
fi

