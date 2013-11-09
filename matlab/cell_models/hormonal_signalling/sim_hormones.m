function [t, c, v] = sim_hormones()
%SIM_SINGLE Simulation with hepatic hormonal module.
%   Returns:
%       t:      vector of time points
%       c:      matrix of concentrations for the time points t
%       v:      matrix of fluxes for the time points t

%   Matthias Koenig (matthias.koenig@charite.de)
%   Copyright 2012 Matthias Koenig
%   date:   121202
clear all, close all, format compact

% Initial concentrations
S0 = [
    1.0     % S1 [mmol/L] glucose extern
    1000    % S2 [pmol/L] insulin
    0.8000  % S3 [pmol/L] glucagon
    0.1600  % S4 [pmol/L] epinephrine
    0.5     % S5 [] gamma function
];  



% Integration
[t,y] = ode15s(@(t,y) dxdt_test(t, y), [0,100], S0, odeset('RelTol', 1e-6));

    function [dydt] = dxdt_test(t, y)
        
       dydt = zeros(size(y));
       
       tau_1 = 10; %[s]
       C_ss = 0;  
       
       v1 = 1/tau_1*(C_ss - y(1)); 
       dydt(1) = v1;    % glucose_ext
    end

% Create figure
fig1 = figure('Name', 'Test', 'Color', [1 1 1]);
size(t)
size(y)

plot(t, y(:,1), 'o-');
line([t(1) t(end)],[0.68*y(1,1) 0.68*y(1,1)],[1 1],'Marker','.','LineStyle','-')
xlabel('time [sec]')
ylabel('A.U.')
end




% % Calculate fluxes
% [~, vtmp] = model_glycolysis(0, S0);
% Nv = numel(vtmp);
% Nt = numel(t);
% v  = zeros(Nt, Nv);
% for k=1:Nt
%     [~, v(k, :)] = model_glycolysis(t(k), c(k, :));
% end
% 
% % Save data for comparison
% res.v = v;
% res.c = c;
% res.t = t;
% save('../results/new.mat', 'res');
% 
% % Compare the results
% compare_results
% 
% % fig_single(t, c, v);