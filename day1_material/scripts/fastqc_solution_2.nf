#!/usr/bin/env nextflow

process fastqc_raw {
    module 'fastqc/0.12.1'
    stageInMode 'copy'
    publishDir 'results/qc_raw', mode: 'copy'

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("*_fastqc.{html,zip}")

    script:
    """
    fastqc -t 4 ${reads}
    """
}

workflow {

    main:
    read_pairs_ch = Channel.fromFilePairs('data/sample_*_R{1,2}.fastq')

    fastqc_raw(read_pairs_ch)
}