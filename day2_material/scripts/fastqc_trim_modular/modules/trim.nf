// modules/trim.nf

process trim {

    module 'trimmomatic/0.39'
    stageInMode 'copy'
    publishDir "${params.outdir}/trimmed", mode: 'copy'

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