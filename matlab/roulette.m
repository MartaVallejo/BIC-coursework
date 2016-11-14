% Roulette wheel selection function

% Implemented with fitness proportionality

function indexes=roulette(population, population_size, chromosome_size, size)
size=min(size, population_size);
p = cumsum(population(:,chromosome_size))/sum(population(:,chromosome_size));
indexes = zeros(1,size);
for i = 1:size
    indexes(i)=find(p>rand(),1);
end
end