###split large fq file into small size
~/software/seqkit split2 -1 ERR10500768_1.clean.fq.gz -2 ERR10500768_2.clean.fq.gz -p 20 -e gz --force -O out &
