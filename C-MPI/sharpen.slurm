#!/bin/bash
#SBATCH --job-name=sharpen
#SBATCH --time=0:05:0
#SBATCH --exclusive
#SBATCH --nodes=2
##SBATCH --ntasks=4
##SBATCH --tasks-per-node=4
##SBATCH --cpus-per-task=1
#SBATCH --partition=standard
##SBATCH --qos=short
#SBATCH --qos=reservation
#SBATCH --reservation=tc069_1525575

# Load the default HPE MPI environment
module load mpt
module load intel-20.4/compilers

# Change to the submission directory
cd $SLURM_SUBMIT_DIR

# Set the number of threads to 1
#   This prevents any threaded system libraries from automatically
#   using threading.
export OMP_NUM_THREADS=1

# Launch the parallel job
#   Using 4 MPI processes on 1 node
#   srun picks up the distribution from the sbatch options
for i in 1 2 4 10 12 16 24 32 36
do
srun --cpu-bind=cores --tasks-per-node=$i ./sharpen
done

