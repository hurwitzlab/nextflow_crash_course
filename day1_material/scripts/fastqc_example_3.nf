#!/usr/bin/env nextflow

/*
 * Run FASTQC
 */
process fastqc {

    module 'fastqc/0.12.1'
    stageInMode 'copy'
    publishDir 'fastqc', mode: 'copy'

    input:
    path reads

    output:
    path "*_fastqc.{html,zip}"

    script:
    """
    fastqc -t 4 ${reads}
    """
}

workflow {

    main:
    // channel: grab all the fastq files
    reads_ch = Channel.fromPath('data/sample_*_*.fastq')     // multiple files!

    // run FASTQC
    fastqc(reads_ch)
}