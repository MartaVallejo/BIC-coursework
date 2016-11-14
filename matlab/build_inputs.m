% Builds the inputs for the ANN

% The 'inputs' variable should be used as ANN inputs, whereas 'input_space'
% is for plotting the results only.

function [inputs, input_spaces] = build_inputs(def_space,nb_points,input_dimension)
input_space=[linspace(def_space(1,1),def_space(1,2),nb_points(1))]';
input_spaces=input_space;
inputs=input_space; % inputs combination, each line of this matrix is a possible input
% Build the input matrix with cartesian product if the input dimension is 2
% or more. Enables to cover the entire input space.
if(input_dimension>=2)
    for i=2:input_dimension
        input_space2=linspace(def_space(i,1),def_space(i,2),nb_points(i))';
        input_spaces=[input_spaces, input_space2];
        [a,b]=ndgrid(1:size(inputs,1),1:length(input_space2));
        inputs=[inputs(a,:),input_space2(b,:)];
    end
end
inputs=inputs';
end