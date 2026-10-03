// pipeline.nf
include { trim } from './modules/trim.nf'
include { fastqc as fastqc_raw     } from './modules/fastqc.nf'
include { fastqc as fastqc_trimmed } from './modules/fastqc.nf'


// set up configs
include { config } from './configs/other.config'

workflow {
    main:
    reads_ch = Channel.fromPath(params.input)

    fastqc_raw(reads_ch)
    trim(reads_ch)
    fastqc_trimmed(trim.out)


    fastwc_raw_collected = fastqc_raw.out.map(html).collect()
    multiqc(fastwc_raw_collected)
}