#!/bin/bash

fastq=$1

echo -n -e "\tread_length\t"
echo -e "reads"
echo -e -n "$fastq\t"
averagecount=$(awk 'NR % 4 == 2 { s += length($1); t++} END {print s/t}' $fastq)
echo -e -n "$averagecount\t"
reads=$(cat $fastq| echo $((`wc -l`/4)))
echo "$reads"


exit 0;
