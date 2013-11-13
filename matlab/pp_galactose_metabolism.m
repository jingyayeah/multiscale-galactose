function [y_pp] = pp_galactose_metabolism(t, p)
%% Calculate periportal galactose time courses.
% Here the simulation profiles in the external metabolites are 
% generated and used to run the model.
% Uses the information in p.x0 to set the values !

%   Copyright Matthias Koenig 2013 All Rights Reserved.

sim_type = 'gal_constant';

%% Set initial concentrations everywhere
y_pp = zeros(p.Nx_out, numel(t));
for kt = 1:numel(t)
   y_pp(:,kt) = p.x0(1:p.Nx_out); 
end

%% Set the selected galactose timecourse
switch (sim_type)
    %case 'gal_profile'
    %    galactose = gal_profile(t);
    case 'gal_constant'
        galactose = gal_constant(t);
    otherwise
        error('pp profile not defined');
end
y_pp(1,:) = 0.0; %rbcM_sin
y_pp(2,:) = 0.0; %suc_sin
y_pp(3,:) = 0.0; %alb_sin
y_pp(4,:) = galactose;
y_pp(5,:) = 0.0; %galM_sin
y_pp(6,:) = 0.0; %h2oM_sin

    %% galactose profile over time
    function [gal] = gal_profile(t)
        %disp('gal_profile');
        gal = zeros(size(t));
        Nt = numel(t);
        steps = 14;
        prof = [linspace(0, 6, steps-1), 0];
        for k=1:Nt
             index = min(floor(steps*t(k)/p.tspan(2))+1, steps);
             gal(k) = prof(index);
        end
    end

    %% constant galactose over time
    function [gal] = gal_constant(t)
        %disp('gal_constant')
        value = y_pp(4,:);
        gal = value; 
    end
        
end