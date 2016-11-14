% Tournament selection method

function indexes = tournament(population_size, size)
k=ceil(population_size/2);
size=min(size, ceil(population_size/2));
% List of chosen individuals
indexes = zeros(1,size);
for i=1:size
    nb_individuals = min(k, population_size);
    % Randomly choose nb individuals in the population
    temp_indexes=randi(population_size,1,nb_individuals);
    % Get the best of them, given that the population is sorted from the
    % best to the worst.
    indexes(i)=min(temp_indexes);
end
end