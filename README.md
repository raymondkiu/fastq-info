# fastq-info
## Calculate fastq reads, average read length, genome size in bp (fasta) and actual sequencing depth/coverage
This includes a few handy yet simple Bash scripts to generate information for 1 or 2 fastq files (paired-end Illumina data)- average reads and read length (if they are trimmed). Addtionally, script 3 can take in fasta assembly of those fastq files and generate the actual sequencing coverage. Script fastq-info.sh can take in fasta assembly of those fastq files and generate the actual sequencing coverage if read length is known.

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
fastq-info.sh has option to include specific read length using -r:
```
% fastq-info.sh -r 125 FILE1.fastq FILE2.fastq FILE3.fasta
```
where 125 can be any read length you want (by default it is set to 100).

## Outputs
It will generate tab-delimited standard outputs e.g.:
```
              read_length     reads
ABC2234.fastq         85    1102746
```
or with coverage using fastq-info.sh, e.g.:
```
sample_name             read_length     reads   genome  coverage
PH091.fna                       101     881394  3337668   53

```

You can save the file simply using > sign:
```
% fastq-info.sh -r 125 FILE1.fastq FILE2.fastq FILE3.fasta > FILE_depth
```
