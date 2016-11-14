%% Main function
% Initializes the ANN to approximate a function, then evolves it thanks to
% a GA. The results of the approximations are displayed while the GA is
% running.

clear all; close all;

%% Topology initialization
internal_layers=[20,40,20]; % number of neurons in the layers of the ANN
input_dimension=2; % dimension of the input vector
output_dimension=1; % dimension of the output vector
range=[15]; % output multiplication factor, same size as output_dimension
topology=[input_dimension,internal_layers,output_dimension]; % Topology of the ANN.
chromosome_size = get_chromosome_size(topology); % size of a chromosome (composed of all the weights/biases of the MLP)
disp('Topology initialized')

%% Pairs building
nb_points=[20,20]; % size equal to input_dimension
def_space=[-2,2;-2,2]; % Definition space of each component of the input.
[inputs, input_spaces]=build_inputs(def_space,nb_points,input_dimension);
outputs=func(inputs); % outputs of the function corresponding to the inputs
disp('Pairs built')

%% GA initialization
population_size=100; % number of chromosomes
population = build_population(population_size, chromosome_size,topology, inputs, outputs, range);
disp('GA initialized')

%% Learning algorithm
nb_iterations = 10000;
nb_mutations = round(population_size/2);
nb_crossovers = round(population_size/2);

figure();
actual_output_R = reshape(outputs,[nb_points(1),nb_points(2)]);
subplot(2,2,1);
surf(input_spaces(:,1),input_spaces(:,2), actual_output_R);


for it=1:nb_iterations
    population = MUTATES_1(chromosome_size, population_size, nb_mutations, population,topology,inputs,outputs,range);
    population = MUTATES_2(chromosome_size, population_size, nb_mutations, population,topology,inputs,outputs,range);
    population = MUTATES_3(chromosome_size, population_size, nb_mutations, population,topology,inputs,outputs,range);
    population = MUTATES_4(chromosome_size, population_size, nb_mutations, population,topology,inputs,outputs,range);
    population = CROSSOVER_1(chromosome_size, population_size, nb_crossovers,population,topology,inputs,outputs,range);
    population = CROSSOVER_2(chromosome_size, population_size, nb_crossovers, population,topology,inputs,outputs,range);
    population = CROSSOVER_3(chromosome_size, population_size, nb_crossovers, population,topology,inputs,outputs,range);

    %% Plotting results
    population=sortrows(population,-chromosome_size);
    best_output = MLP(inputs,topology,population(1,:),range);
    best_output_R = reshape(best_output,[nb_points(1),nb_points(2)]);
    if(input_dimension==2)

        f1=subplot(2,2,2);
        cla(f1);
        surf(input_spaces(:,1),input_spaces(:,2), best_output_R);
        subplot(2,2,3)
        hold on;
        plot(it,sum(min(100,abs((outputs-best_output)./outputs)*100))/length(outputs),'.r')
        f2=subplot(2,2,4);
        cla(f2);
        surf(input_spaces(:,1),input_spaces(:,2), actual_output_R-best_output_R);
    elseif(input_dimension==1)
        f1=subplot(1,3,1);
        cla(f1);
        plot(input_spaces,outputs);
        hold on;
        plot(input_spaces,MLP(inputs,topology,population(1,:),range));
        subplot(1,3,2)
        hold on;
        plot(it,sum(abs((outputs-MLP(inputs,topology,population(1,:),range))))/length(outputs),'.r')
        subplot(1,3,3)
        plot(input_spaces,outputs-MLP(inputs,topology,population(1,:),range));
    end
    drawnow();
end

%% Save the best result for other use
best = population(1,:);
save('best.mat',best);
