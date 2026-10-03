// main.nf
include { trim }                     from './modules/trim.nf'
include { fastqc as fastqc_raw }     from './modules/fastqc.nf'
include { fastqc as fastqc_trimmed } from './modules/fastqc.nf'
include { megahit }                  from './modules/megahit.nf'
include { multiqc }                  from './modules/multiqc.nf'

workflow {
    main:
    reads_ch = Channel.fromPath(params.input)

    fastqc_raw(Channel.value('qc_raw'), reads_ch)
    trim(reads_ch)
    fastqc_trimmed(Channel.value('qc_trimmed'), trim.out)
    megahit(trim.out)

    // .mix() merges both fastqc calls' outputs and trim's output into one
    // channel; .collect() waits for every item across every sample before
    // emitting once, so multiqc runs a single time over everything instead
    // of once per file.
    multiqc(fastqc_raw.out.collect())
    multiqc(fastqc_trimmed.out.collect())
}
