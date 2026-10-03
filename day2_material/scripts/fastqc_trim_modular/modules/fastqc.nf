// modules/fastqc.nf

process fastqc {
    container '/usr/local/usrapps/brc/brc_modules/images/quay.io_biocontainers_fastqc:0.12.1--hdfd78af_0.sif'
    stageInMode 'copy'
    publishDir "${params.outdir}/fastqc", mode: 'copy'
    label 

    input:
    path reads

    output:
    path "*_fastqc.{html,zip}"

    script:
    """
    fastqc -t 4 ${reads}
    """
}