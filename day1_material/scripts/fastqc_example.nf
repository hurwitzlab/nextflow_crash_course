#!/usr/bin/env nextflow

/*
 * Run FASTQC
 */
process fastqc {

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
    //reads_ch = Channel.fromPath('data/sample1_1.fastq')
    // channel: grab all the fastq files
    reads_ch = Channel.fromPath('data/sample*_*.fastq')

    // run FASTQC
    fastqc(reads_ch)
}