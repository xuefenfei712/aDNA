#!/bin/sh
INDIR=/home/users/l/liuxu/scratch/00raw
OUTDIR=/home/users/l/liuxu/scratch/02Adapter

export file=$1

while read -r i; do
 echo "#!/bin/bash
#SBATCH --job-name=${i}Adap
#SBATCH --partition=shared-cpu
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=10000 #in MB
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=xuexue.liu@unige.ch
#SBATCH --mail-type=END,FAIL

cd ${OUTDIR}
module load GCC/8.3.0
module load Anaconda3
source activate /home/users/l/liuxu/anaconda3/envs/paleomix
AdapterRemoval --file1 $INDIR/${i}_R1.fastq.gz --file2 $INDIR/${i}_R2.fastq.gz --basename DS24 --barcode-list ${OUTDIR}/x${i} --barcode-mm 1 --barcode-mm-r1 1 --barcode-mm-r2 1 --minlength 25 --trimns --trimqualities --minadapteroverlap 3 --mm 5 --threads 24 --collapse --gzip" > "${i}.AdapterRemoval.sh"
done < "$file"
