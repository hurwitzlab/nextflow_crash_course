// modules/trim.nf

process trim {
    container '/usr/local/usrapps/brc/brc_modules/images/quay.io_biocontainers_trimmomatic:0.40--hdfd78af_0.sif'
    stageInMode 'copy'
    publishDir "${params.outdir}/trimmed", mode: 'copy'

    input:
    path reads

    output:
    path "trimmed_${reads}"

    script:
    """
    trimmomatic SE -threads ${task.cpus} ${reads} trimmed_${reads} \\
        SLIDINGWINDOW:4:20 MINLEN:36
    """
}
