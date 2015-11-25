%% Initializes the scripts
% Adds the necessary subfolders to the path.
% Copyright Matthias Koenig 2013-2015 All Rights Reserved.

clear all, close all, clc
fprintf('Installation Script\n');
folder = pwd;
pinfo = {'', 'tools', 'plots', 'sims', 'tools/csv'};
for kp = 1:numel(pinfo)
    p = strcat(folder, '/', pinfo{kp}); 
    addpath(p);
    fprintf('\t%s\n', p);
end
fprintf('... added to path.\n');

savepath();
