%% Optimization script
% Let us consider the best MLP we can obtain with the main script. The goal
% is to find the global maximum of the appromimated function/tuned MLP
% using a genetic algorithm.
% This script has been designed for 2D functions only.

clear all; close all;

%% Topology initialization
internal_layers=[20,40,20]; % number of neurons in the layers of the ANN
input_dimension=2; % dimension of the input vector
output_dimension=1; % dimension of the output vector
range=[15]; % output multiplication factor, same size as output_dimension
topology=[input_dimension,internal_layers,output_dimension]; % Topology of the ANN.
chromosome_size = 3; % size of a chromosome (composed of 2d input and fitness)
disp('Topology initialized')

%% Pairs building
nb_points=[200,200]; % size equal to input_dimension
def_space=[-2,2;-2,2]; % Definition space of each component of the input.
[inputs, input_spaces]=build_inputs(def_space,nb_points,input_dimension);
disp('Pairs built')

%% Displays the approximated function
best = load('best.mat'); % Loads the best MLP that has been created.
outputs = reshape(MLP(inputs, topology, best.best, range),[nb_points(1),nb_points(2)]);
figure();
surf(input_spaces(:,1),input_spaces(:,2), outputs);

%% Genetic algorithm
population_size=150;
population=build_population_inputs(population_size,def_space, topology, best.best, range);
nb_iterations=100;
nb_mutations=ceil(population_size/5);

for i=1:nb_iterations
    population = mutate(population', population_size, chromosome_size, nb_mutations, topology, best.best, range, def_space)';
    clf;
    hold on;
    surf(input_spaces(:,1),input_spaces(:,2), outputs);
    plot3(population(1,:),population(2,:),population(3,:),'.r');
    drawnow();
end
