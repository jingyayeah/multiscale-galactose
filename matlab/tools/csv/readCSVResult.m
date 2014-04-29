function [
%% Reads a CSV results file and generates the model variables.
% Here the vectors and matrices have to be generated again. 
% It is the reverse process of writing the csv in the first place.




% Everything has to be ready to call the create_named_variables.
% p, x, t have to be available
%
% x and t can be generated from the csv if the p structure has been
% generated.
create_named_variables;