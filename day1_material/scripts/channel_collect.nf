#!/usr/bin/env nextflow
workflow {

    main:
    // channel: paired fastq, view it
    read_pairs_ch = Channel
    .fromPath('data/sample_*_R1.fastq')
    .collect()
    .view()
}