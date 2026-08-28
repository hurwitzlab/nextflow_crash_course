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

process trim {
    module 'trimmomatic/0.40'
    stageInMode 'copy'
    publishDir 'results/trimmed', mode: 'copy'

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id),
          path("${sample_id}_R1_paired.fastq"),
          path("${sample_id}_R2_paired.fastq")

    script:
    """
    trimmomatic PE -threads 4 \\
        ${reads[0]} ${reads[1]} \\
        ${sample_id}_R1_paired.fastq ${sample_id}_R1_unpaired.fastq \\
        ${sample_id}_R2_paired.fastq ${sample_id}_R2_unpaired.fastq \\
        SLIDINGWINDOW:4:20 MINLEN:36
    """
}

process fastqc_trimmed {
    module 'fastqc/0.12.1'
    stageInMode 'copy'
    publishDir 'results/qc_trimmed', mode: 'copy'

    input:
    tuple val(sample_id), path(r1_paired), path(r2_paired)

    output:
    tuple val(sample_id), path("*_fastqc.{html,zip}")

    script:
    """
    fastqc -t 4 ${r1_paired} ${r2_paired}
    """
}

workflow {

    main:
    read_pairs_ch = Channel.fromFilePairs('data/sample_*_R{1,2}.fastq')

    fastqc_raw(read_pairs_ch)
    trim(read_pairs_ch)
    fastqc_trimmed(trim.out)
}