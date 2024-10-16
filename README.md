1. Activate suitable environment for quick_bed_sort: conda activate/mamba activate
2. Make sure you have all input files i.e. shuf.a.bed.gz shuf.b.bed.gz chrom_selection.tsv
3. Run snakemake file using command "snakemake -p --snakefile sort_bed_by_chrom.smk --cores all". You will get output as sorted merged file in "sorted" folder.
