#!/bin/bash

#print the options
usage () {
  echo ""
  echo "This bash script can take in fasta assembly of those fastq files and generate the actual sequencing coverage if read length is known (parse into option -r)"
  echo ""
  echo "Usage: $0 [options] fastq1 fastq2 fasta"
  echo "Option:"
  echo " -r readlength (e.g.125;default:100)"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 1.2"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
}
version () { echo "version 1.2";}
author () { echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk";}

#dafault value for readlength
readlength=100

while getopts ':r:hav' opt;
do
  case $opt in
    r) readlength=$OPTARG ;;
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
  echo "Correct usage: $0 [options] fastq1 fastq2 fasta"
  echo "Option: -r readlength (e.g.100;default:100)"
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
LN=$(echo "$readlength*2*$readcount")
G=$genomesize
coverage=$(echo "$LN/$G"|bc)

#print outputs
echo -n -e "sample_name\t"
echo -n -e "\tread_length\t"
echo -n -e "reads\t"
echo -n -e "genome\t"
echo -e "coverage"
echo -n -e "$fasta\t"
echo -n -e "$readlength\t"
echo -n -e "$readcount\t"
echo -n -e "$genomesize\t"
echo -e "$coverage"

#remove intermediary files
rm "$fasta"-single;
rm "$fasta"-oneline;

