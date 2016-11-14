% Computes MLP output to a given input

function output=MLP(input,topology,chromosome,range)
output = input;
start = 1;
for i=1:length(topology)-1
    % The weight/biases matrix of layer i is built and used to compute its
    % output.
    mat_size = (topology(i)+1)*topology(i+1);
    mat = chromosome(start:mat_size+start-1);
    output = f(reshape(mat,topology(i+1),topology(i)+1)*[output;2*ones(1,size(output,2))]);
    start=mat_size+1;
end
output = (range.*output')';
end