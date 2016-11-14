% Returns the size of a chromosome, which contains all the weights and
% biases of a given ANN.

function chromosome_size=get_chromosome_size(topology)
% Initialized to 1 because the chromosome also contains its own fitness
chromosome_size = 1;
parfor i=1:length(topology)-1
    % Each weight matrix is serialized into the chromosome. So its length is
    % equal to the number of element in each matrix. Here, biases vectors are
    % considered to be concatenated with weight matrices :
    %               W*inputs+b = [W,b]*[inputs;1]
    chromosome_size = chromosome_size + (topology(i)+1)*topology(i+1);
end
end