#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Inport other manifests from subworkflows
include { getKmerVectorManifest } from '../kmer_vector/manifest_kmer_vectors.nf'
include { getStraingeAnalysisManifest } from './manifest_strainge_analysis.nf'

def getManifest() {
    [
        //
        // Main Workflow
        //

        manifest:                                  "manifest.json",
        params:                                    "params.json",

        // fastq
        r1:                                        "fastq/r1.fq.gz",
        r2:                                        "fastq/r2.fq.gz",
        trimmed_r1:                                "fastq/trimmed_r1.fq.gz",
        trimmed_r2:                                "fastq/trimmed_r2.fq.gz",

        human_r1:                                  "fastq/human_r1.fq.gz",
        human_r2:                                  "fastq/human_r2.fq.gz",
        no_eukaryota_r1:                           "fastq/no_eukaryota_r1.fq.gz",
        no_eukaryota_r2:                           "fastq/no_eukaryota_r2.fq.gz",
        escherichia_r1:                            "fastq/escherichia_r1.fq.gz",
        escherichia_r2:                            "fastq/escherichia_r2.fq.gz",

        // metrics
        read_metrics_all:                          "metrics/read_metrics_all.json",
        read_metrics_human:                        "metrics/read_metrics_human.json",
        read_metrics_no_eukaryota:                 "metrics/read_metrics_no_eukaryota.json",
        read_metrics_escherichia:                  "metrics/read_metrics_escherichia.json",
        qc_summary:                                "metrics/qc_summary.json",

        // logs
        fastp_log_html:                            "log/fastp_log.html",
        fastp_log_json:                            "log/fastp_log.json",

        //
        // Kmer Pipeline
        //

        // kraken report
        kraken_reads:                              "kmer_pipeline/report/kraken_reads.txt",
        kraken_report:                             "kmer_pipeline/report/kraken_report.txt",
        kraken_json_report:                        "kmer_pipeline/report/kraken_report.json",

        // bracken report
        bracken_stats:                             "kmer_pipeline/report/bracken_stats.txt",
        bracken_report:                            "kmer_pipeline/report/bracken_report.txt",
        bracken_json_report:                       "kmer_pipeline/report/bracken_report.json",

        //
        // Assembly Pipeline
        //

        // reads
        mapped_bam:                                "assembly_pipeline/reads/mapped.bam",
        mapped_bai:                                "assembly_pipeline/reads/mapped.bam.bai",
        unmapped_bam:                              "assembly_pipeline/reads/unmapped.bam",
        r1_unaligned:                              "assembly_pipeline/reads/r1_unaligned.fq.gz",
        r2_unaligned:                              "assembly_pipeline/reads/r2_unaligned.fq.gz",

        // assembly
        contigs:                                   "assembly_pipeline/assembly/contigs.fasta",
        scaffolds:                                 "assembly_pipeline/assembly/scaffolds.fasta",
        assembly_path:                             "assembly_pipeline/assembly/scaffolds.paths",
        fastg:                                     "assembly_pipeline/assembly/assembly_graph.fastg",
        assembly_dir:                              "assembly_pipeline/assembly",

        // metaquast
        metaquast:                                 "assembly_pipeline/metrics/metaquast.tar.gz",

        // contig bins
        bins:                                      "assembly_pipeline/binning/bins",
        bins_json:                                 "assembly_pipeline/bins.json",
        bins_summary:                              "assembly_pipeline/binning/summary.txt",
        bins_log:                                  "assembly_pipeline/binning/log.txt",

        // annotations
        annotations_dir:                           "assembly_pipeline/annotations",
        annotations_faa:                           "assembly_pipeline/annotations/annotated_genome.faa",
        annotations_fna:                           "assembly_pipeline/annotations/annotated_genome.fna",
        annotations_gbk:                           "assembly_pipeline/annotations/annotated_genome.gbk",
        annotations_gff:                           "assembly_pipeline/annotations/annotated_genome.gff",
        annotations_ffn:                           "assembly_pipeline/annotations/annotated_genome.ffn",

        // qualities
        crispr_arrays_dir:                         "assembly_pipeline/metrics/crispr",
        crispr_report:                             "assembly_pipeline/metrics/crispr/combined.crispr_arrays",

        // Phage Detection
        virsorter_round1_config:                   "assembly_pipeline/phages/virsorter2/round1/config.yaml",
        virsorter_round1_viral_boundary:           "assembly_pipeline/phages/virsorter2/round1/final_viral_boundary.tsv",
        virsorter_round1_viruses:                  "assembly_pipeline/phages/virsorter2/round1/final_viral_combined.fa",
        virsorter_round1_viral_score:              "assembly_pipeline/phages/virsorter2/round1/final_viral_score.tsv",
        complete_phage_genomes:                    "assembly_pipeline/phages/checkv/complete_phage_genomes.tsv",
        prophage_completeness:                     "assembly_pipeline/phages/checkv/completeness.tsv",
        prophage_contamination:                    "assembly_pipeline/phages/checkv/contamination.tsv",
        predicted_prophages:                       "assembly_pipeline/phages/checkv/predicted_prophages.fna",
        prophage_quality_summary:                  "assembly_pipeline/phages/checkv/quality_summary.txt",
        predicted_phages:                          "assembly_pipeline/phages/checkv/predicted_phages.fna",
        virsorter_round2_config:                   "assembly_pipeline/phages/virsorter2/round2/config.yaml",
        virsorter_round2_viruses:                  "assembly_pipeline/phages/virsorter2/round2/final_viral_combined.fa",
        virsorter_round2_score:                    "assembly_pipeline/phages/virsorter2/round2/final_viral_score.tsv",

        // read QC
        qc_insert_size_metrics:                    "assembly_pipeline/metrics/reads_qc/insert_size_metrics.txt",
        qc_insert_size_histogram:                  "assembly_pipeline/metrics/reads_qc/insert_size_histogram.pdf",
        qc_gc_summary_metrics:                     "assembly_pipeline/metrics/reads_qc/gc_summary_metrics.txt",
        qc_gc_bias_metrics:                        "assembly_pipeline/metrics/reads_qc/gc_bias_metrics.txt",
        qc_gc_bias_chart:                          "assembly_pipeline/metrics/reads_qc/gc_bias_chart.pdf",
        qc_alignment_summary_metrics:              "assembly_pipeline/metrics/reads_qc/alignment_summary_metrics.txt",
        qc_quality_yield_metrics:                  "assembly_pipeline/metrics/reads_qc/quality_yield_metrics.txt",
        qc_base_distribution_metrics:              "assembly_pipeline/metrics/reads_qc/base_distribution_metrics.txt",
        qc_base_distribution_chart:                "assembly_pipeline/metrics/reads_qc/base_distribution_chart.pdf",
        qc_wgs_metrics:                            "assembly_pipeline/metrics/reads_qc/wgs_metrics.txt",

        // metrics
        checkm_qc:                                 "assembly_pipeline/metrics/checkm_qc.txt",

        //
        // k-mer vector pipeline
        //
        *:getKmerVectorManifest(''),
        // prefixes must match the `include` parameter passed in main.nf
        *:getKmerVectorManifest('noneuk_'),
        *:getKmerVectorManifest('ecoli_'),

        //
        // StrainGE Pipeline
        //
        *:getStraingeAnalysisManifest()

    ]
}