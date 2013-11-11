function [y_pp] = pp_galactose_metabolism(t, p)
%% PP_GALACTOSE_METABOLISM - Calculate periportal time courses.
% Here the simulation profiles in the external metabolites are 
% generated and used to run the model.

%   Copyright Matthias Koenig 2013 All Rights Reserved.

y_pp = zeros(p.Nx_out, numel(t));
% constant initial concentrations (use the start initial concentrations
% pp)

for kt = 1:numel(t)
   y_pp(:,kt) = p.x0(1:p.Nx_out)*3; 
end

%sim_type = 'gal_profile';
sim_type = 'gal_constant';

galactose = zeros(size(t));
switch (sim_type)
    case 'gal_profile'
        galactose = gal_profile(t);
    case 'gal_constant'
        galactose = gal_constant(t);
    otherwise
        error('pp profile not defined');
end

y_pp(1,:) = 0.0; %rbc_sin
y_pp(2,:) = 0.0; %rbcM_sin
y_pp(3,:) = 0.0; %suc_sin
y_pp(4,:) = 0.0; %alb_sin
y_pp(5,:) = galactose;
y_pp(6,:) = 0.0; %galM_sin
y_pp(7,:) = 0.0; %h2oM_sin


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

    % constant galactose over time
    function [gal] = gal_constant(t)
        %disp('gal_constant')
        value = 2.0;
        gal = value * ones(size(t)); 
    end
        
end