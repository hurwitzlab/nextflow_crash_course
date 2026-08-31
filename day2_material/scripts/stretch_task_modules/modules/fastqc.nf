// modules/fastqc.nf

process fastqc {
    module 'fastqc/0.12.1'
    stageInMode 'copy'
    publishDir "${params.outdir}/${qc_stage}", mode: 'copy'

    input:
    val qc_stage
    path reads

    output:
    path "*_fastqc.{html,zip}"

    script:
    """
    fastqc -t 4 ${reads}
    """
}