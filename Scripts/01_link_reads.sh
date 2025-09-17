#!/bin/bash

#*----------Cluster specification----------
#SBATCH --mail-type=fail
#SBATCH --job-name="01_link_reads"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1:00:00
#SBATCH --mem=1000
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/egraf/assembly_annotation_course/Job_log/slurm-%A.out

#*----------Variables----------
USER='egraf'


#*----------Link to reads----------
ln -s /data/courses/assembly-annotation-course/raw_data/Edi-0 ./Data/
ln -s /data/courses/assembly-annotation-course/raw_data/RNAseq_Sha ./Data/


