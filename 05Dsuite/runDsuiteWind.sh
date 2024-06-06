#!/bin/sh
export list=$1

#echo -e "${list}"'\t'"AM803"'\t'"E.kiang" >${list}_AM803
echo -e "${list}"'\t'"E.kiang"'\t'"AM803" >${list}_AM803
cat ${list}_AM803
~/software/Dsuite/Build/Dsuite Dinvestigate -w 20,5 56misQC_gt0.9_1.1M.vcf AM803.pop  ${list}_AM803
#echo "Duite finished"
