#PBS -N woltka_ogu_table_generation_8172021
#PBS -S /bin/bash
#PBS -m bae
#PBS -M jhc103@ucsd.edu
#PBS -e localhost:${HOME}/cluster_logs/${PBS_JOBNAME}_${PBS_JOBID}.err
#PBS -o localhost:${HOME}/cluster_logs/${PBS_JOBNAME}_${PBS_JOBID}.log
#PBS -l nodes=1:ppn=4
#PBS -l mem=240gb
#PBS -l walltime=24:00:00
###
# Resource utilization: To run shogun bowtie alignment it took 10 hrs of wall time or around 15 minutes to get to 2 files for alignment.
###


## Set up neccesary dependencies
wd='/panfs/panfs1.ucsd.edu/panscratch/jhc103/microbiome-analysis'
outputd="${wd}/02-woltka-output"
inputd="${wd}/01-sam-files"
database="/projects/wol/release/databases/shogun"

mkdir -p $outputd
cd $wd
## Load required packages
source activate qiime2-2020.11

#woltka classify -i $inputd --map wol-20April2021/taxonomy/taxid.map --nodes wol-20April2021/taxonomy/nodes.dmp --names wol-20April2021/taxonomy/names.dmp -o $outputd/rank_free.biom
#woltka classify -i $inputd --lineage wol-20April2021/taxonomy/lineages.txt -o $outputd/rank_free_lineages.biom
#woltka classify -i $inputd --lineage wol-20April2021/taxonomy/lineages.txt --rank phylum,class,genus,species -o $outputd


woltka classify -i $inputd -o $outputd/ogu.biom
