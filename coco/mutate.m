function population = mutate(population, population_size, chromosome_size, nb_mutations, topology, best, range, def_space)

population=sortrows(population,-chromosome_size);
indexes=selection(population, population_size, chromosome_size, nb_mutations);
new_population=population(indexes,:)+[0.1*(2*rand(nb_mutations,2)-1) zeros(nb_mutations,1)];
new_population(:,1)=max(min(new_population(:,1),def_space(1,2)),def_space(1,1));
new_population(:,2)=max(min(new_population(:,2),def_space(2,2)),def_space(2,1));
new_population(:,chromosome_size)=MLP(new_population(:,1:2)',topology,best,range);
population=sortrows([population;new_population],-chromosome_size);
population=population(1:population_size,:);

end