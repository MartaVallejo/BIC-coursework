This folder contains all the MATLAB files for the first part of the coursework.

The script main.m can be executed to evolve a MLP to approximate a (1/2D -> 1D)
function.
It contains parameters that can be changed. It automatically saves the best
individual at the end of the algorithm into best.mat.
The selection.m file enables to choose which selection algorithm is used in the
MLP GA.
The function to approximate is defined in func.m.

The second script part2.m can be used to find the maximum of the approximated
function, ie the max output of the MLP.
Be careful to use the same parameters as in main.m.
