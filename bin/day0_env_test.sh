#!/bin/bash

set -euo pipefail

# --- ENV ---
module use /usr/local/usrapps/brc/brc_modules/modules
module load nextflow/26.04.3 java/17 apptainer
export NXF_APPTAINER_CACHEDIR="$APPTAINER_CACHEDIR"

# --- Test environment setup ---
# can you clone from github? (skip if it's already there)
SCRATCH_DIR="/share/$GROUP/$USER"
if [[ -d "$SCRATCH_DIR/nextflow_crash_course" ]]; then
    echo "nextflow_crash_course already exists in $SCRATCH_DIR, skipping clone"
else
    git clone https://github.com/hurwitzlab/nextflow_crash_course.git "$SCRATCH_DIR/nextflow_crash_course"
fi
echo "PASS: GitHub connectivity OK"

# is nextflow loaded properly, and is apptainer actually wired in?
mkdir -p /share/$GROUP/$USER/tmp
cd /share/$GROUP/$USER/tmp
nextflow run seqeralabs/nf-canary -with-apptainer
echo "PASS: Nextflow + Apptainer OK"

# --- Exit ---
echo "ALL CHECKS PASSED"
echo DONE
