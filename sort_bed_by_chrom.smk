chrom_selection = [l.strip() for l in open("chrom_selection.tsv")]

rule all:
    input:
        "sorted/merged_sorted.bed"

rule split_by_chrom:
    input:
        bedlist = ["shuf.a.bed", "shuf.b.bed"]
    params:
        chrom_list = ",".join(chrom_selection)
    output:
        all_chrom_files = expand("splitted/chrom_{chrom}.bed", chrom=chrom_selection)
    shell:
        "sh scripts/split.sh '{input.bedlist}' {params.chrom_list} splitted/"

rule sort_individual_chrom_files:
    input:
        indiv_chrom_file = "splitted/chrom_{chrom}.bed"
    output:
        sorted_file = "split_sorted/chrom_{chrom}.bed"
    shell:
        "mkdir -p split_sorted; sort -S4G --parallel=4 -k2,2n -k3,3n {input.indiv_chrom_file} > {output.sorted_file}"

def collect_files(wildcards):
    flist = []
    for c in chrom_selection:
        flist.append("split_sorted/chrom_{chrom}.bed".format(chrom=c))
    return flist

rule combine_sorted_files:
    input:
        list_of_sorted_files = collect_files
    output:
        final_sorted = "sorted/merged_sorted.bed"
    shell:
        "mkdir -p sorted; cat {input.list_of_sorted_files} | sort -k1,1 -k2,2n > {output.final_sorted}"
