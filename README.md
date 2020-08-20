# Install
```shell
git clone https://github.com/Genetalks/callMHC.git
make -C callMHC
```

# Usage:
```shell
path_of_precisionFDA/asm/asm_calling_mhc\
  -i input.bam \
  -o test \
  -p test \
  -R hg38.fa
```
**Tips**:
- Input BAM file should be sorted by genomic coordinates and indexed.
- Reference genome file should be indexed. If not, please index with  the command:  ```samtools faidx hg38.fa```.
- All outputs will be put to output directory specified with ```-o``` option, all output files with value of option ```-p``` as prefix.

# Methods
1. Reads mapped to MHC region were extracted from input BAM file and writen into FASTQ file.
2. Call hifiasm to assembly the MHC region using reads extracted above, the resolved haplotype graph was used for subsequente analysis, 
   assembled haplotypes were extracted from the assembly graph.
3. The assembled haplotypes were mapped to chromsome 6 using minimap2 in a asm-to-asm fashion. Take the mutation rate in MHC region into consideration,
   ```-x``` option of minimap2 was set to ```asm10```.
4. The candidate events were built from haplotype alignments, for the sake of sensitivity, the well mapped supplementary alignments were retained.
   Canidate SNPs were merged into MNPs and adjacent variants were clustered and merged in terms of haplotype phase information. Also a right shift
   operation were performed to simplify the variants representation for complex mixed variants, eg. two overlapped deletions. The right shift
   algorithm also resolved some local misalignment in low complexity regions.
