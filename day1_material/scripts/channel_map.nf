#!/usr/bin/env nextflow
workflow {

    main:
    // channel: paired fastq, view it
    read_pairs_ch = Channel
    .fromFilePairs('data/sample_*_R{1,2}.fastq')
    .map { sample_id, files -> sample_id }
    .view()
}