#!/usr/bin/env nextflow

params.input      = 'data/sample_*_*.fastq'
params.outdir     = 'results'

process fastqc_raw {

    module 'fastqc/0.12.1'
    stageInMode 'copy'
    publishDir 'params.outdir/qc_raw', mode: 'copy'

    input:
    path reads

    output:
    path "*_fastqc.{html,zip}"

    script:
    """
    fastqc -t 4 ${reads}
    """
}

process fastqc_trimmed {

    module 'fastqc/0.12.1'
    stageInMode 'copy'
    publishDir 'params.outdir/qc_trimmed', mode: 'copy'

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
    publishDir 'params.outdir/trimmed', mode: 'copy'

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
    reads_ch = Channel.fromPath(params.input)

    fastqc_raw(reads_ch)
    trim(reads_ch)
    fastqc_trimmed(trim.out)
}