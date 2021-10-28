#PBS -N shogun_alignment_17_8092021
#PBS -S /bin/bash
#PBS -m bae
#PBS -M jhc103@ucsd.edu
#PBS -e localhost:${HOME}/cluster_logs/${PBS_JOBNAME}_${PBS_JOBID}.err
#PBS -o localhost:${HOME}/cluster_logs/${PBS_JOBNAME}_${PBS_JOBID}.log
#PBS -l nodes=1:ppn=32
#PBS -l mem=120gb
#PBS -l walltime=24:00:00
###
# Resource utilization: To run shogun bowtie alignment it took 10 hrs of wall time or around 15 minutes to get to 2 files for alignment.
###

number=17

## Set up neccesary dependencies
wd='/panfs/panfs1.ucsd.edu/panscratch/jhc103/microbiome-analysis'
tmpd="${wd}/tmpd$number"
inputd="${wd}/00-seq-files-fa/folder$number"
outputd="${wd}/01-sam-files"
database="/projects/wol/release/databases/shogun"

cd $wd
## Load required packages
source activate qiime2-2020.11
mkdir -p $outputd
mkdir -p $tmpd
## First use seqtk to interleave our gz fastq files 
#while read f1 f2 f3; do
#	echo $(basename $f1)
#	echo $(basename $f2)
#	echo $(basename ${f3%combined.fastq.gz}interleaved.fa)
#done < $inputf 


#for f in $(eval echo $inputd/{$start..$stop}*.fa)
for f in $inputd/*.fa
do
	## Skip empty expansions 
	echo "database: " 
	echo $database
	echo "input file: "
	echo $f
	nfname=$(basename ${f%.fa}.sam)
	echo "output file: "
	echo $nfname
#	bowtie2 -x $database -p 16 -f $f -S $outputN -k 16 --np 1 --mp "1,1" --rdg "0,1" --rfg "0,1" --score-min "L,0,-0.05" --very-sensitive --no-head --no-unal --verbose 
	
## This is the equivalent shogun run 
	shogun align -d $database -a bowtie2 -t 32 -p 0.95 -i $f -o $tmpd
	mv ${tmpd}/alignment.bowtie2.sam ${outputd}/$nfname
	gzip ${outputd}/$nfname
done

rm -r $tmpd
