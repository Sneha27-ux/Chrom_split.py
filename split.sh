#!/bin/bash
# $1: comma-separated list of bed files (input)
# $2: comma-separated list of chromosomes
# $3: output prefix

for file in $(echo $1 | tr "," "\n")
do
    zcat -f $file 
done | python scripts/chrom_split.py $2 $3
