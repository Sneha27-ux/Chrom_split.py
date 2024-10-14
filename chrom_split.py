import sys
from collections import defaultdict

chrom_list = sys.argv[1].split(",")  # List of chromosomes
filenam_prefix = sys.argv[2]         # Prefix for output files

# Dictionary to store open file pointers for each chromosome
fp_dict = {}
chrom_flag = defaultdict(lambda: False)

# Open file for each chromosome
for chrom in chrom_list:
    fname = f"{filenam_prefix}chrom_{chrom}.bed"
    tmp_fp = open(fname, "w")
    fp_dict[chrom] = tmp_fp
    chrom_flag[chrom] = True

# Read stdin and write lines to appropriate chromosome file
for line in sys.stdin:
    chrom_name = line.split("\t")[0]
    if chrom_flag[chrom_name]:
        fp_dict[chrom_name].write(line)

# Close all file pointers
for chrom in chrom_list:
    fp_dict[chrom].close()
