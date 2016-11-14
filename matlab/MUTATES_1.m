% Mutates randomly chosen chromosomes with the vector mutation method

% Adds a gaussian random noise between [-0.5,0.5] to a chromosome.
% The former population, and the temp one are concatenated, then ranked. The
% n best individual are chosen to be in the new population.

function population = MUTATES_1(chromosome_size, population_size, nb_mutations, population,topology,inputs,outputs,range)
population=sortrows(population,-chromosome_size);
best_so_far = population(1,:);
indexes = selection(population, population_size, chromosome_size, nb_mutations);
temp_population = population(indexes,:)+[randn(nb_mutations,chromosome_size-1)-0.5,zeros(nb_mutations,1)];
parfor m=1:nb_mutations
    temp_chromosome = temp_population(m,:);
    mlp_outputs=MLP(inputs,topology,temp_chromosome,range);
    temp_chromosome(chromosome_size)=fitness(mlp_outputs,outputs);
    temp_population(m,:) = temp_chromosome;
end
population=sortrows([population;temp_population],-chromosome_size);
population=population(1:population_size,:);
new_best = population(1,:);
if(best_so_far ~= new_best)
    disp('Mutation 1')
end
end