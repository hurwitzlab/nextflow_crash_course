// modules/extract_unaligned.nf

process extract_unaligned {
    container '/usr/local/usrapps/brc/brc_modules/images/quay.io_biocontainers_samtools:1.19--h50ea8bc_0.sif'
    stageInMode 'copy'
    publishDir "${params.outdir}/host_removed", mode: 'copy'

    input:
    path sam

    output:
    path "unaligned.fastq"

    script:
    """
    samtools view -f 4 -b ${sam} | samtools fastq - > unaligned.fastq
    """
}
