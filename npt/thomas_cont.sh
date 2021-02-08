#!/bin/bash -l

#$ -P Gold
#$ -A Imperial_CEng

#Batch script to run an OpenMP threaded job under SGE.

# Request ten minutes of wallclock time (format hours:minutes:seconds).
#$ -l h_rt=48:00:00

# Request 1 gigabyte of RAM for each core/thread (must be an integer followed by M, G, or T)
#$ -l mem=1G

# Request 15 gigabyte of TMPDIR space (default is 10 GB)
#$ -l tmpfs=10G

# Set the name of the job.
#$ -N JOBNAME 

# Request 24 cores.
#$ -pe mpi 48

# Set the working directory to somewhere in your scratch space.
# Replace "<your_UCL_id>" with your UCL user ID
#$ -cwd

# 8. Run the application.

module unload compilers mpi
module load compilers/intel/2018/update3
module load mpi/intel/2018/update3/intel
module load gromacs/2019.3/intel-2018

cp $GMXLIB/* .

gerun mdrun_mpi -maxh 48 -s topol.tpr  -cpi state.cpt

rm table*.xvg
