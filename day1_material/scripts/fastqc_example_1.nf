#!/usr/bin/env nextflow

/*
 * Run FASTQC
 */
process fastqc {

    container '/usr/local/usrapps/brc/brc_modules/images/quay.io_biocontainers_fastqc:0.12.1--hdfd78af_0.sif'    
    
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
    reads_ch = Channel.fromPath('../data/sample_001_R1.fastq')

    // run FASTQC
    fastqc(reads_ch)
}
