% Mutates randomly chosen chromosomes with the n-gene mutation method

% A random number of genes are randomly selected in each chosen chromosome,
% and a uniform noise between [-0.0005,0.0005] is then added to them.
% The former population, and the temp one are concatenated, then ranked. The
% n best individual are chosen to be in the new population.

function population = MUTATES_4(chromosome_size, population_size, nb_mutations, population,topology,inputs,outputs,range)
population=sortrows(population,-chromosome_size);
best_so_far = population(1,:);
indexes = selection(population, population_size, chromosome_size, nb_mutations);
temp_population = population(indexes,:);
parfor m=1:nb_mutations
    temp_chromosome = temp_population(m,:);
    genes = randi(chromosome_size-1,[1,randi(chromosome_size-1)]);
    temp_chromosome(genes) = temp_chromosome(genes)+0.001*(rand(1,length(genes))-0.5);
    mlp_outputs=MLP(inputs,topology,temp_chromosome,range);
    temp_chromosome(chromosome_size)=fitness(mlp_outputs,outputs);
    temp_population(m,:) = temp_chromosome;
end
population=sortrows([population;temp_population],-chromosome_size);
population=population(1:population_size,:);
new_best = population(1,:);
if(best_so_far ~= new_best)
    disp('Mutation 4')
end
end