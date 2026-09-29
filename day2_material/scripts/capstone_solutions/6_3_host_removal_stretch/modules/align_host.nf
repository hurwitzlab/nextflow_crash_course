// modules/align_host.nf

process align_host {
    container '/usr/local/usrapps/brc/brc_modules/images/quay.io_biocontainers_bwa:0.7.17--hed695b0_7.sif'
    stageInMode 'copy'

    input:
    path reads
    path reference

    output:
    path "aligned.sam"

    script:
    """
    bwa index ${reference}
    bwa mem ${reference} ${reads} > aligned.sam
    """
}
