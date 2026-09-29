// modules/multiqc.nf

process multiqc {
    container '/usr/local/usrapps/brc/brc_modules/images/quay.io_biocontainers_multiqc:1.21--pyhdfd78af_0.sif'
    publishDir "${params.outdir}/multiqc", mode: 'copy'

    input:
    path reports

    output:
    path "multiqc_report.html"

    script:
    """
    multiqc .
    """
}
