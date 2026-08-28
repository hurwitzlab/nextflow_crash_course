#!/usr/bin/env nextflow
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


process trim {

    module 'trimmomatic/0.40'
    stageInMode 'copy'
    publishDir 'results/trimmed', mode: 'copy'

    input:
    path reads

    output:
    path "trimmed_${reads}"

    script:
    """
    trimmomatic SE -threads 4 ${reads} trimmed_${reads} \\
        SLIDINGWINDOW:4:20 MINLEN:36
    """
}

workflow {

    main:
    reads_ch = Channel.fromPath('data/sample_*_*.fastq')

    fastqc(reads_ch)
    trim(reads_ch)
    fastqc(trim.out)
}