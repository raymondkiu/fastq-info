# fastq_info
## Compute estimated sequencing depth/coverage of genomes
This script generates estimated coverage information for paired-end fastq files (Illumina WGS data). No dependencies needed - runs smoothly on Linux or Mac as this is a pure Bash script. Should generate outcomes within seconds. You will need raw paired-end fastq files (R1 and R2) and genome assemblies to estimate the coverage.

The calculation of coverage is based the [Lander/Waterman equation](https://doi.org/10.1016/0888-7543(88)90007-9):

C = LN / G

Where coverage (C) based on read length (L), number of reads (N), and genome size (G)
from https://emea.illumina.com/science/technology/next-generation-sequencing/plan-experiments/read-length.html

## Usage
### Options
```
$ fastqinfo-2.0.sh -h

This bash script calculates actual sequencing coverage(X)
Fasta assembly and raw fastq files (paired-end) are needed

Usage: /fastqinfo-2.0.sh [options] fastq_R1 fastq_R2 fasta_assembly
Option:
 -r insert size (default=125)
 -h print usage and exit
 -a print author and exit
 -v print version and exit

Version 2.0
Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk
```

### Run the software
```
$ ./fastqinfo-2.0.sh -r INSERT_SIZE R1.fastq R2.fastq ASSEMBLY.fasta
```
### Inputs
You will need R1 and R2 raw fastq files (paired-end) and a genome assembly (draft genome will do) to compute the coverage, or sequencing depth (X). This is based on the fact that Illumina raw fastq files have the same insert size for every read.
- Additionally you will need the insert size (or read length) for the fastq files, to quickly generate this:
```
$ head -n 2 R1.fastq |tail -n 2|wc -c
$ 250
```
This is actually printing the second line of the fastq file and calculate the AGTC counts as follows:
```
@NB5
GTTTGTATTGATTGAGGTGTTGTAACATTAGCATTACCTATCTCAAAGCCATTCTCTAACATATCTTTTGCATCTATGAGACAACAATTGGTTAATGGTTGAAATGGATGGTAATCTAAGTCGTGAAAATGAATATCTCCCGATTGATGTG
+
AAAAAE6EAEEEEEEEEE/EEEEEE6/EAEEE/EEEEEEEEEEEEEEEEE/AEEEEE/EEEE/EEEEEAEAEAEEEAEEAEEEEAEEA<AEE</AEEEEEAEAE/EEAE<<<////EAAEE<AA/A/A<<6<<E<A/<<<6/A<<EEEA/E
```
**WARNING: Using the wrong insert size will bias the outcomes and accuracy. Also this script is designed to calculate microbial genomes not tested on eukaryotic genomes.**

## Outputs
It will generate tab-delimited standard outputs e.g.:
```
Sample   	Insert	Reads	Genome	Coverage(X)
CA-68.fna	250	1014649	2499579	202
```
- Insert: insert size in bp
- Reads: total read counts in both paired-end fastq files
- Genome: Size (bp) of genome assembly supplied
- Coverage(X): estimated sequencing depth of the genome

## Issues
This script has been tested on Linux OS, it should run smoothly with no dependencies needed. Please report any issues to the [issues page](https://github.com/raymondkiu/fastq-info/issues).

## License
[GPLv3](https://github.com/raymondkiu/fastq-info/blob/master/LICENSE)

## Author
Raymond Kiu Raymond.Kiu@quadram.ac.uk
