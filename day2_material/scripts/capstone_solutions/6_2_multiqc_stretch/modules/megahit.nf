// modules/megahit.nf

process megahit {
    container '/usr/local/usrapps/brc/brc_modules/images/quay.io_biocontainers_megahit:1.2.9--h8b12597_0.sif'
    stageInMode 'copy'
    publishDir "${params.outdir}/assembly", mode: 'copy'

    input:
    path reads

    output:
    path "megahit_out/final.contigs.fa"

    script:
    """
    megahit -r ${reads} -o megahit_out
    """
}
