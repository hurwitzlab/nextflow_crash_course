#!/usr/bin/env nextflow

/*
 * Run FASTQC
 */
process fastqc {

    module 'fastqc/0.12.1'
    stageInMode 'copy'
    publishDir 'fastqc', mode: 'copy'

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
    // channel: paired fastq files
    reads_ch = Channel.fromFilePairs('data/sample_*_R{1,2}.fastq')

    // run fastqc
    fastqc(reads_ch)
}