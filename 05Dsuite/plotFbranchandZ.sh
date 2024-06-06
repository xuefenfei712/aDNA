#!/bin/sh
export tree=$1
export dsuittree=$2
#useage conda activate py3
# sh PlotFbranch.sh 85pop.treeout 85SET_tree.txt 
~/software/Dsuite/Build/Dsuite Fbranch -p 0.001 $tree $dsuittree >fbranch.out
~/.conda/envs/py3.11/bin/python ~/software/Dsuite/utils/dtools.py fbranch.out $tree --outgroup Outgroup --use_distance --dpi 1200 --tree-label-size 10
####get Zscore
~/software/Dsuite/Build/Dsuite Fbranch -Z NJTREE-use.tre 56_sites_tree.txt >56_sites_tree_Zscore.txt
Rscript MakeFbranch-Zscore.R 56_sites_tree_Zscore.txt
sed -i 's/X//g' all_new_zscore.txt 
~/.conda/envs/py3.11/bin/python ~/software/Dsuite/utils/dtools.py all_new_zscore.txt $tree --outgroup Outgroup --use_distance --dpi 1200 --tree-label-size 10
