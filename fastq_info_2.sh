#!/bin/bash

fastq1=$1  #input 1
fastq2=$2  #input 2
readlength1=$(awk 'NR % 4 == 2 { s += length($1); t++} END {print s/t}' $fastq1) #calculate read length for fastq file 1
readlength2=$(awk 'NR % 4 == 2 { s += length($1); t++} END {print s/t}' $fastq2) #calculate read length for fastq file 2
totalreadlength=$(echo "$readlength1+$readlength2"|bc) #calculate total read length
averagereadlength=$(echo "$totalreadlength/2"|bc) #calculate average read length by parsing into bc command - which truncates the decimal numbers by default in multiplication/division

readcount1=$(cat $fastq1| echo $((`wc -l`/4))) #read count in file 1
readcount2=$(cat $fastq2| echo $((`wc -l`/4))) #read count in file 2
totalreadcount=$(echo "$readcount1+$readcount2"|bc) #total read count of file 1 and file 2
averagereadcount=$(echo "$totalreadcount/2"|bc) #average read count - parsed into bc command to be rounded

echo -n -e "\tread_length\t"
echo -e "reads"
echo -e -n "$fastq1\t"
echo -e -n "$averagereadlength\t"
echo "$averagereadcount"

exit 0;
