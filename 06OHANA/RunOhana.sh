#!/bin/sh
export file=$1
export k=$2
###use whole genome to get best k matrix
convert=~/.conda/envs/ohana/bin/convert 
#plink recode
plink --horse --bfile ${file} --recode12  --tab --out ${file}
##convert plink2dgm
$convert ped2dgm ${file}.ped ${file}.dgm
###qoutmatrix, similar with admixture, if your admixture use prune data, here shoule be the same
qpas -k ${k} -qo k${k}_qout.matrix -fo k${k}_fout.matrix -e 0.0001 ${file}.dgm
#plink --vcf SV.vcf.gz --recode12 tab --out SV --allow-extra-chr --chr-set 18 --double-id
#$convert ped2dgm ${file}.ped ${file}.dgm #####卤拢证SV.ped碌?                                                         霉肗P.prune.ped一胢kdir -p k${k}/selscan
#qpas -k ${k} -qo k${k}_qout.matrix -fo k${k}_fout.matrix -e 0.0001 ${file}.dgm
####get fout matrix, ancestral component matrix
nemeco ${file}.dgm k${k}_fout.matrix -e 0.0 -co k${k}_C.matrix
mkdir k${k}
mkdir -p k${k}/selscan
mkdir -p k${k}/f_matrices
mkdir -p k${k}/c_matrices

Rscript make_c_matrix.R k${k}_C.matrix ${k}

###calculate selection
qpas -k ${k} ${file}.dgm -qi k${k}_qout.matrix -fo ./k${k}/f_matrices/${file}_F.matrix -e 0.0001 -fq ##k${k}_qout.matrix肗P露寐值碌?                                                

n=$[k-1]
for i in $( eval echo {0..$n} )
do
  selscan ${file}.dgm ./k${k}/f_matrices/${file}_F.matrix ./k${k}_C.matrix -cs ./k${k}/c_matrices/C_p${i}.matrix >./k${k}/selscan/k${k}_p${i}.out
done

for i in $( eval echo {0..$n} )
do
tail -n +2 k${k}/selscan/k${k}_p${i}.out | paste ${file}.map - | cut -f 1,2,4,6 >k${k}_p${i}
sed -i '1 i Chr\tID\tPos\tlle-ratio' k${k}_p${i}

python plot_Manhattan.py --infile k${k}_p${i} --chr-col Chr --ylabel lle-ratio --loc-col Pos --val-col lle-ratio --outfile k${k}_p${i}.png
done
#to know ancestray compo
 qpas ${file}.dgm -k ${k} -e 0.001 -qo q-unsupervised.matrix -fo f-insupervised.matrix 
###convert to tree
convert cov2nwk k${k}_C.matrix k${k}-tree.nwk 
