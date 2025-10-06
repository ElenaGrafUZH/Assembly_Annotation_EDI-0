#!/bin/bash

#*----------Cluster specification----------
#SBATCH --job-name="12_run_merqury"
#SBATCH --mail-type=fail
#SBATCH --cpus-per-task=16
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A.out
#SBATCH --error=./Job_log_errors/error_merqury_%A.e


#*----------Variables----------
USER='egraf'
WORKDIR="/data/users/${USER}/assembly_annotation_course"
CONTAINERMERQURY=/containers/apptainer/merqury_1.3.sif

#output directories
OUTDIR="${WORKDIR}/12_merqury"
DBDIR="$OUTDIR/meryl_db"
READ_DB="$DBDIR/hifi.meryl"

#fasta files
FLYEASSEMBLY="${WORKDIR}/Data/Assemblies/flye_hifi_assembly.fasta"
HIFIASMASSEMBLY="${WORKDIR}/Data/Assemblies/hifiasm_Edi-0.asm.bp.p_ctg.fa"
LJAASSEMBLY="${WORKDIR}/Data/Assemblies/lja_assembly.fasta"


#*----------Path Variable----------
export MERQURY="/usr/local/share/merqury"

#*---------- Run merqury ----------
run_merqury() {
  local asm_fa=$1
  local label=$2
  [[ -s "$asm_fa" ]] || { echo "Skipping $label (missing): $asm_fa" >&2; return 0; }

  # Ensure clean outputs for this label
  rm -f "$OUTDIR/${label}" "$OUTDIR/${label}".* 2>/dev/null || true

  echo "===> Merqury: $label"
  apptainer exec --bind /data:/data --pwd "$OUTDIR" "$CONTAINERMERQURY" \
    bash -lc "merqury.sh '$READ_DB' '$asm_fa' '$label'"
}

mkdir -p "$OUTDIR"

run_merqury "$FLYEASSEMBLY" flye
run_merqury "$HIFIASMASSEMBLY" hifiasm
run_merqury "$LJAASSEMBLY" lja

echo "===> Done. Results: $OUTDIR"

#*----------Check merqury status----------
if [[ $? -eq 0 ]]; then
    echo "merqury completed successfully"
else
    echo "merqury failed"
    exit 1
fi

