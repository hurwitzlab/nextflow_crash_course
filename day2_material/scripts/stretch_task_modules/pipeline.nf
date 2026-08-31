// pipeline.nf
include { trim } from './modules/trim.nf'
include { fastqc as fastqc_raw     } from './modules/fastqc.nf'
include { fastqc as fastqc_trimmed } from './modules/fastqc.nf'

workflow {
    main:
    reads_ch = Channel.fromPath(params.input)

    fastqc_raw(Channel.value('qc_raw'), reads_ch)
    trim(reads_ch)
    fastqc_trimmed(Channel.value('qc_trimmed'), trim.out)
}