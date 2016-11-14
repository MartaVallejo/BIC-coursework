% Crossovers chromosomes with the line crossover method

% A new chromosome is created by choosing two parents and
% adding their difference randomly modulated to one of them, which has also
% been modified.

function population = CROSSOVER_3(chromosome_size, population_size, nb_crossovers, population,topology,inputs,outputs,range)
population=sortrows(population,-chromosome_size);
best_so_far = population(1,:);
temp_population=zeros(nb_crossovers,chromosome_size);
parfor m=1:nb_crossovers
    alpha=0.1*(2*rand-1);
    u=0.5*(2*rand-1);
    ch1 = population(selection(population,population_size,chromosome_size, 1),:);
    ch2 = population(selection(population,population_size,chromosome_size, 1),:);
    new_chromosome = [ch1(1:chromosome_size-1)-alpha+u*(ch2(1:chromosome_size-1)-ch1(1:chromosome_size-1)) inf];
    mlp_outputs=MLP(inputs,topology,new_chromosome,range);
    new_chromosome(chromosome_size)=fitness(mlp_outputs,outputs);
    temp_population(m,:)=new_chromosome;
end
population=sortrows([population;temp_population],-chromosome_size);
population=population(1:population_size,:);
new_best = population(1,:);
if(best_so_far ~= new_best)
    disp('Crossover 3')
end
end