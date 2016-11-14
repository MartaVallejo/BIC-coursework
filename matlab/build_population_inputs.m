%% Creates a population of input for the best MLP
% The fitness of each chromosome is also concatenated to the population
% matrix. The fitness of the chromosome corresponds here to its
% corresponding output by the MLP. The higher, the better.

function population = build_population_inputs(population_size, def_space, topology, best, range)
xmin=def_space(1,1);
xmax=def_space(1,2);
ymin=def_space(2,1);
ymax=def_space(2,2);
x=(-xmin+xmax)*rand(1,population_size)+xmin;
y=(-ymin+ymax)*rand(1,population_size)+ymin;
population=[x;y];
population=[population;MLP(population, topology, best, range)];
end