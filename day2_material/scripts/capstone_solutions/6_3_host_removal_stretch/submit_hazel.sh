#!/bin/bash
#SBATCH --job-name=capstone_6_3_host_removal
#SBATCH --output=nf-head-%j.out
#SBATCH --error=nf-head-%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G

set -euo pipefail

# Run from wherever this script lives, so nextflow.config next to main.nf is
# picked up correctly no matter where `sbatch` was called from.
cd "$(dirname "$0")"

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
# host_reference has no shared default (see nextflow.config) — download it
# ahead of time from the login node (§6.3 of the doc), then either edit the
# default in nextflow.config or override it here:
#   nextflow run main.nf -profile hazel -resume \
#       --host_reference /path/to/your/host_genome.fa
nextflow run main.nf -profile hazel -resume
