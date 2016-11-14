% Fitness function

% The fitness of a chromosome is the inverse of the sum of squared errors
% between the actual outputs and the ANN outputs.

function f = fitness(mlp_outputs, outputs)
    f=1/sum(sum(abs(mlp_outputs - outputs).^2));
end