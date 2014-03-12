%% Initializes the scripts
% Adds the necessary subfolders to the path.

%   Matthias Koenig (2014-03-10)
%   Copyright Matthias Koenig 2013 All Rights Reserved.
clc
fprintf('Installation Script\n');
folder = pwd;
pinfo = {'', 'tools', 'plots', 'parameter_distribution'};
for kp = 1:numel(pinfo)
    p = strcat(test, '/', pinfo{kp}); 
    addpath(p);
    fprintf('\t%s\n', p);
end
fprintf('... added to path.\n');

savepath();
