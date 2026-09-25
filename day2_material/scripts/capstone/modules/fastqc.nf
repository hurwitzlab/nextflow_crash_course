// modules/fastqc.nf

process fastqc {
    module 'fastqc/0.12.1'
    stageInMode 'copy'

    input:
    path reads

    output:
    path "*_fastqc.{html,zip}"

    script:
    """
    fastqc -t 4 ${reads}
    """
}