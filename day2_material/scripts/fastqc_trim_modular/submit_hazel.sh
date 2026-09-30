#!/bin/bash
#SBATCH --job-name=fastqc_trimmomatic_modular
#SBATCH --output=nf-head-%j.out
#SBATCH --error=nf-head-%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G

set -euo pipefail
echo "Running in: $PWD" #to make sure we are running on the right place

# --- ENV ---
# BRC-provided software modules (nextflow, apptainer, etc.) live under this path
module use /usr/local/usrapps/brc/brc_modules/modules
module load nextflow/26.04.3 java/17 apptainer
export NXF_APPTAINER_CACHEDIR="$APPTAINER_CACHEDIR"

# --- Launch the pipeline ---
# This job only runs the Nextflow "head" process, which then submits one SLURM
# job per task via the `hazel` profile (see nextflow.config) — keep this
# wrapper job's own resources small, the real compute happens per-task.
#
# To override the defaults from nextflow.config (e.g. run on one sample, or a
# different output folder), add flags here, e.g.:
#   nextflow run main.nf -profile hazel -resume \
#       --input '/gpfs_backup/bioinfo_data/training_data/nextflow_crash_course/sample_2_*.fastq.gz' \
#       --outdir results_sample2
nextflow run main.nf -profile hazel -resume
