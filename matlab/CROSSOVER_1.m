% Crossovers chromosomes with the uniform random crossover method

% Two parents are randomly selected form the population. Some genes are
% randomly selected from the first ones, and are inherited by the child.
% The missing genes are provided by the second parent.

function population = CROSSOVER_1(chromosome_size, population_size, nb_crossovers,population,topology,inputs,outputs,range)
population=sortrows(population,-chromosome_size);
best_so_far = population(1,:);
temp_population=zeros(nb_crossovers,chromosome_size);
parfor m=1:nb_crossovers
    ch1 = population(selection(population,population_size,chromosome_size, 1),:);
    ch2 = population(selection(population,population_size,chromosome_size, 1),:);
    gene = randi(chromosome_size-1,[1,round((chromosome_size-1)/(randi(chromosome_size-1)))]);
    new_chromosome = ch1;
    new_chromosome(gene)=ch2(gene);
    mlp_outputs=MLP(inputs,topology,new_chromosome,range);
    new_chromosome(chromosome_size)=fitness(mlp_outputs,outputs);
    temp_population(m,:)=new_chromosome;
end
population=sortrows([population;temp_population],-chromosome_size);
population=population(1:population_size,:);
new_best = population(1,:);
if(best_so_far ~= new_best)
    disp('Crossover 1')
end
end