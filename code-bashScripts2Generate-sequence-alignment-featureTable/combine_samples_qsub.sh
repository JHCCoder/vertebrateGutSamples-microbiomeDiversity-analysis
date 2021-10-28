#!/bin/bash
#PBS -V
#PBS -N sample_combine_fix_882021
#PBS -l nodes=1:ppn=10
#PBS -l walltime=10:00:00
#PBS -e localhost:${HOME}/cluster_logs/${PBS_JOBNAME}_${PBS_JOBID}.err
#PBS -o localhost:${HOME}/cluster_logs/${PBS_JOBNAME}_${PBS_JOBID}.log
#PBS -l mem=20gb
#PBS -M jhc103@ucsd.edu
#PBS -m abe
####
##Approximately used 46 mins to combine 95 samples (190 samples) so its about 2samples per min.
####

## Paths that will be used in the script 
pathToNameIDFile="/panfs/panfs1.ucsd.edu/panscratch/jhc103/microbiome-analysis/sampleID_fix20.txt"
pathToFiles="/panfs/panfs1.ucsd.edu/panscratch/jhc103/microbiome-analysis/paths_to_r1r2combined_files_for_sampleConcat_13881.txt"
## Query unknowns against database of the some genome, ad remove reads that match that genome
while read -r sampleID finalFile; do
  #zcat $forward $reverse | gzip -c > $final
  cat $pathToFiles | grep $sampleID | xargs cat > $finalFile
done < $pathToNameIDFile
