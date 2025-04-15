#!/bin/bash

# Choose the number of processes with -n #, where # is below the number of
# cores/threads available on your CPU (which one depends on the next flag).

# You can omit "--use-hw-thread-cpus" if you only want physical CPU cores to show
# up as available slots. I found the best results for my computer used ~80%
# of my processor's threads, but what's best for you may vary.

NCORES=2

mpirun --use-hwthread-cpus -n $NCORES pw.x -i GaAs.scf.in | tee GaAs.scf.out

mpirun --use-hwthread-cpus -n $NCORES pw.x -i GaAs.bands.in | tee GaAs.bands.out

mpirun --use-hwthread-cpus -n $NCORES bands.x -i GaAs.bandsplot.in | tee GaAs.bandsplot.out

gnuplot plot.gp