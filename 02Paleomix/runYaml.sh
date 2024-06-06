module load GCC/8.3.0
module load Anaconda3
source activate /home/users/l/liuxu/anaconda3/envs/paleomix

cd /home/users/l/liuxu/scratch/03map
paleomix bam_pipeline run --max-threads 50 --bwa-max-threads 4  --bowtie2-max-threads 50 FEG045.yaml --jar-root ~/jar_root2/ --temp-root ./tmp/ 
