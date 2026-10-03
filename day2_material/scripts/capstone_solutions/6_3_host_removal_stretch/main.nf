// main.nf
//
// Note (end of §6.3 in the doc): align_host + extract_unaligned are always
// used together and could be pulled into a subworkflow of their own. This
// workshop never introduces subworkflow syntax (`take:`/`main:`/`emit:`), so
// they're kept as two plain, chained processes here to stay consistent with
// everything else taught today — worth revisiting once you're past this
// workshop's scope.
include { trim }                     from './modules/trim.nf'
include { fastqc as fastqc_raw }     from './modules/fastqc.nf'
include { fastqc as fastqc_trimmed } from './modules/fastqc.nf'
include { align_host }               from './modules/align_host.nf'
include { extract_unaligned }        from './modules/extract_unaligned.nf'
include { megahit }                  from './modules/megahit.nf'

workflow {
    main:
    reads_ch          = Channel.fromPath(params.input)
    host_reference_ch = Channel.fromPath(params.host_reference).value()

    fastqc_raw(Channel.value('qc_raw'), reads_ch)
    trim(reads_ch)
    fastqc_trimmed(Channel.value('qc_trimmed'), trim.out)

    align_host(trim.out, host_reference_ch)
    extract_unaligned(align_host.out)
    megahit(extract_unaligned.out)
}
