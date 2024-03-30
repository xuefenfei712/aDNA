#!/bin/sh
#SBATCH --job-name=FEG077.yaml
#SBATCH --partition=public-cpu
#SBATCH --time=4-00:00:00
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
paleomix bam_pipeline run --max-threads 50 --bwa-max-threads 4  --bowtie2-max-threads 50 FEG077.yaml --jar-root ~/jar_root2/ --temp-root ./tmp/
