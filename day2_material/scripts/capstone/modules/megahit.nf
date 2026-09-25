// modules/fastqc.nf

process megahit {
    container '/usr/local/usrapps/brc/brc_modules/images/CONTAINER!!!!! FIXXX' //TODO: ADD CONTAINER
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