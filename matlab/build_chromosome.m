% Chromosome initialization

% Each weight is included in [-1,1]
% A chromosome represents all the weights of the ANN and all its biases. It contains the
% serialized matrices of each layer, and the fitness of the chromosome.
% The weights are initialized randomly between [-1,1], and the biases on
% the range of the input space. The last element of a chromosome is its
% fitness.

function chromosome = build_chromosome(topology,range,inputs,outputs,chromosome_size)
chromosome = [2*rand(1,chromosome_size-1)-1 inf];
biases = [];
id=0;
for i=1:length(topology)-1
    if(~isempty(biases))
        id = biases(length(biases));
    end
    biases = [biases (topology(i)+1)*[1:topology(i+1)]+id];
end
chromosome(biases) = chromosome(biases)*max(max(inputs));
mlp_outputs=MLP(inputs,topology,chromosome,range);
chromosome(chromosome_size)=fitness(mlp_outputs,outputs);
end