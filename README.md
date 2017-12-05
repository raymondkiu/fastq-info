# fastq_info
## Calculate fastq reads, average read length, genome size in bp (fasta) and actual sequencing depth/coverage
This includes a few handy yet simple Bash scripts to generate information for 1 or 2 fastq files (paired-end Illumina data)- average reads and read length (if they are trimmed). Addtionally, script 3 can take in fasta assembly of those fastq files and generate the actual sequencing coverage. Script 4 can take in fasta assembly of those fastq files and generate the actual sequencing coverage if read length is known (parse into option -r).

## Usage
For fastq_info.sh, it only takes 1 fastq file:
```
% ./fastq_info.sh FILE.fastq
```
For fastq_info_2.sh, it takes 2 fastq files (for paired-end data):
```
% ./fastq_info_2.sh FILE1.fastq FILE2.fastq
```
For fastq_info_3.sh, it takes 2 fastq files (paired-end) and its assembly fasta file to compute the sequencing coverage:
```
% ./fastq_info_3.sh FILE1.fastq FILE2.fastq FILE3.fasta
```
For fastq_info_4.sh, it takes 2 fastq files (paired-end) and its assembly fasta file, with an additional read length (if known then use this) to compute the sequencing coverage:
```
% ./fastq_info_3.sh -r READLENGTH (def:100) FILE1.fastq FILE2.fastq FILE3.fasta
```


## Outputs
It will generate tab-delimited standard outputs e.g.:
```
           read_length     reads
ABC2234.fastq         85    1102746
```
or with coverage using fastq_info_3.sh, e.g.:
```
  average_read_length     reads   genome  coverage
ABC123.fasta    125      1102746   2859342  73
```

