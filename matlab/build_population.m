% Population initialization

% Builds a large population of chromosomes. Each of them is initialized randomly,
% its fitness is then evaluated. The best ones are chosen to be part of the
% initial population.

function population = build_population(population_size, chromosome_size,topology, inputs, outputs, range)
% Creates a population five time bigger than required
first_batch_size = 5*population_size;
population = zeros(first_batch_size,chromosome_size);
parfor i=1:first_batch_size
    population(i,:) = build_chromosome(topology,range,inputs,outputs, chromosome_size);
end
population = sortrows(population,-chromosome_size);
population = population(1:population_size,:);
end