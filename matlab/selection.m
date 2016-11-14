% Choice of chromosome selection method

function indexes=selection(population, population_size, chromosome_size, size)
%indexes=roulette(population, population_size, chromosome_size, size);
indexes=tournament(population_size, size);
end