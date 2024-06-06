#!/bin/sh
export tree=$1
export vcf=$2
export set=$3
#sh runDsuiteDtrios.sh NJTREE-new.tre 56_qc.vcf 56new-set.txt
~/software/Dsuite/Build/Dsuite Dtrios -c -t ${tree} ${vcf} ${set}
