#!/usr/bin/env nextflow

/*
 * Run FASTQC
 */
process fastqc {

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
    // channel: grab one fastq file
    reads_ch = Channel.fromPath('data/sample_001_1.fastq')

    // run FASTQC
    fastqc(reads_ch)
}