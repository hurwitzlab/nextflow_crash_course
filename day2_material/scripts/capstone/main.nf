// pipeline.nf
include { trim } from './modules/trim.nf'
include { fastqc as fastqc_raw     } from './modules/fastqc.nf'
include { fastqc as fastqc_trimmed } from './modules/fastqc.nf'
include { megahit } from './modules/megahit.nf'

workflow {
    main:
    reads_ch = Channel.fromPath(params.input)

    fastqc_raw(reads_ch)
    trim(reads_ch)
    fastqc_trimmed(trim.out)
    megahit(trim.out)
}