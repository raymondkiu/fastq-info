# fastq_info
## Calculate fastq reads and average read length
This is a handy yet simple Bash script to generate information for 1 or 2 fastq files- average reads and read length (if they are trimmed).

## Usage
For fastq_info.sh, it only takes 1 fastq file:
```
% ./fastq_info.sh FILE.fastq
```
For fastq_info_2.sh, it takes 2 fastq files:
```
% ./fastq_info_2.sh FILE1.fastq FILE2.fastq
```
## Outputs
It will generate tab-delimited standard outputs e.g.:
```
           read_length     reads
ABC2234.fastq         85    1102746
```
