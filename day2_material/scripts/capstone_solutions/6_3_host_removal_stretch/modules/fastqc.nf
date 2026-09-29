// modules/fastqc.nf

process fastqc {
    container '/usr/local/usrapps/brc/brc_modules/images/quay.io_biocontainers_fastqc:0.12.1--hdfd78af_0.sif'
    stageInMode 'copy'
    // A directive that depends on an input value (qc_stage) has to be a
    // closure, not a plain interpolated string — otherwise qc_stage isn't in
    // scope yet when Nextflow evaluates the directive and the run fails with
    // "No such variable: qc_stage".
    publishDir { "${params.outdir}/${qc_stage}" }, mode: 'copy'

    input:
    val qc_stage
    path reads

    output:
    path "*_fastqc.{html,zip}"

    script:
    """
    fastqc -t ${task.cpus} ${reads}
    """
}
