#!/bin/bash

#print the options
usage () { 
  echo ""
  echo "This bash script calculates actual sequencing coverage(X)"
  echo "Fasta assembly and raw fastq files (paired-end) are needed"
  echo ""
  echo "Usage: $0 [options] fastq_R1 fastq_R2 fasta_assembly"
  echo "Option:"
  echo " -r insert size (default=125)"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 2.0"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
}
version () { echo "version 2.0";}
author () { echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk";}

#default value for readlength
insert=125

while getopts 'r:hav' opt;do
  case $opt in
    r) insert=$OPTARG;;
     h) usage; exit;;
    a) author; exit;;
    v) version; exit;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
    :) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
    *) echo "Unimplemented option: -$OPTARG" >&2; exit 1;; 

esac
done

# skip over the processed options
shift $((OPTIND-1)) 

#check for mandatory positional parameters
if [ $# -lt 3 ]; then
  echo "Correct usage: $0 [options] fastq_R1 fastq_R2 fasta_assembly"
  echo "use -h to list options"
#  echo "Option: -r readlength (e.g.100;default:100)"
  echo "Option -r must be included to calculate the correct coverage"
  echo ""
exit 1
fi
fastq1=$1  #input 1
fastq2=$2  #input 2
fasta=$3
#To calculate read counts
readcount1=$(cat $fastq1| echo $((`wc -l`/4))) #read count in file 1
readcount2=$(cat $fastq2| echo $((`wc -l`/4))) #read count in file 2
totalreadcount=$(echo "$readcount1+$readcount2"|bc) #total read count of file 1 and file 2
readcount=$(echo "$totalreadcount/2"|bc) #average read count - parsed into bc command to be rounded

#To calculate genome size
awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n }' $fasta > "$fasta"-single
cat "$fasta"-single|awk 'NR%2==0'| awk '{print length($1)}' > "$fasta"-oneline
genomesize=$(awk '{ sum += $1 } END { print sum }' "$fasta"-oneline)

#sequencing depth= LN/G = read length * 2(paired-end) * average reads / genome size
LN=$(echo "$insert*2*$readcount")
G=$genomesize
coverage=$(echo "$LN/$G"|bc)

#print outputs
echo -n -e "Sample   \t"
echo -n -e "Insert\t"
echo -n -e "Reads\t"
echo -n -e "Genome\t"
echo -e "Coverage(X)"
echo -n -e "$fasta\t"
echo -n -e "$insert\t"
echo -n -e "$readcount\t"
echo -n -e "$genomesize\t"
echo -e $coverage

#remove intermediary files
rm "$fasta"-single;
rm "$fasta"-oneline;
