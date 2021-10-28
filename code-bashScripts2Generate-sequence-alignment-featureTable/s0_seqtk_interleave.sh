#PBS -N seqtk_interleave_fix20_8082021
#PBS -S /bin/bash
#PBS -m bae
#PBS -M jhc103@ucsd.edu
#PBS -e localhost:${HOME}/cluster_logs/${PBS_JOBNAME}_${PBS_JOBID}.err
#PBS -o localhost:${HOME}/cluster_logs/${PBS_JOBNAME}_${PBS_JOBID}.log
#PBS -l nodes=1:ppn=32
#PBS -l mem=64gb
#PBS -l walltime=32:00:00
###
# Resource utilization: To run metaphlan on five samples we used 1 hr of wall time, 7 gb of vmem and 3 gb of mem. So to process one samples required around 12 mins.
###

## Set up neccesary dependencies
wd='/panfs/panfs1.ucsd.edu/panscratch/jhc103/microbiome-analysis'
inputf="${wd}/paths_to_forward_reverse_files_for_r1r2concat_fix20.txt"
outputd="${wd}/00-seq-files-fa"
# Set the range to run metaphlan Ustart="C"

cd $wd
## Load required packages
source activate qiime2-2020.11
mkdir -p outputd

## First use seqtk to interleave our gz fastq files 
while read f1 f2 f3; do
	echo "files involved:" 
	echo $(basename $f1)
	echo $(basename $f2)
	output_f=$(basename ${f3%combined.fastq.gz}interleaved.fa)
	echo $output_f
	seqtk mergepe $f1 $f2 | seqtk seq -A > $outputd/$output_f	
done < $inputf 

##for f in $(eval echo $inputd/{$start..$stop}*.gz)
#do
#	shogun align -d wol-20April2021/databases/bowtie2/ -a bowtie2 -t 32 -p 0.95 -i $f -o $outputd
#done
