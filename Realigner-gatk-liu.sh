#!/bin/sh
export file=$1
while read -r i;
do
echo "#!/bin/sh
#SBATCH --job-name=${i}realign
#SBATCH --partition=shared-cpu
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=5
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=10000 #in MB
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=xuexue.liu@unige.ch
#SBATCH --mail-type=END,FAI

module load GCC/8.3.0
module load Anaconda3
source activate /home/users/l/liuxu/anaconda3/envs/paleomix

cd /home/users/l/liuxu/scratch/03map
java -jar ~/jar_root2/GenomeAnalysisTK.jar -T RealignerTargetCreator -R ~/Ref/GCA_949782905.1_mRanTar1.h1.1_genomic.fasta -I ${i}.RanTar_Bowtie2.bam -o ${i}.target.intervals -nt 5
java -Xmx8G -Djava.io.tmpdir=/tmp -jar ~/jar_root2/GenomeAnalysisTK.jar -T IndelRealigner -R ~/Ref/GCA_949782905.1_mRanTar1.h1.1_genomic.fasta -I ${i}.RanTar_Bowtie2.bam -targetIntervals ${i}.target.intervals -o ${i}.RanTar_Bowtie2.realigner.bam
paleomix coverage ${i}.RanTar_Bowtie2.realigner.bam --ignore-readgroup
mapDamage -i ${i}.RanTar_Bowtie2.realigner.bam -r ~/Ref/GCA_949782905.1_mRanTar1.h1.1_genomic.fasta --downsample=100000 --merge-reference-sequences" > "realign.${i}.sh"
 done <${file}
