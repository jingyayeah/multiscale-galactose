% Run the variable strategies
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normal drop in oxygen between cell 5 and 10
Nc = 25;

% Generate the strategies
sim.sim_f_gly = [0.1 0.2 0.3 0.4 0.5  1.1450 1.7900 2.4350 3.0800 3.4025]
sim.sim_f_oxi = [0.5620    0.5465    0.5310    0.5155  0.5  0.4  0.3  0.2 0.1 0.05]

tmp = linspace(0, Nc-1, Nc);
f_gly = 0.1 + (3.4025-0.1) * tmp.^3./(tmp.^3 + 5^3);
f_oxi = 0.562 - (0.562-0.05) * tmp.^3./(tmp.^3 + 5^3);

f_gly =  1.7900 + (3.4025- 1.7900) * tmp.^3./(tmp.^3 + 5^3);
f_oxi = 0.4 - (0.4-0.05) * tmp.^3./(tmp.^3 + 5^3);

%sim.sim_f_gly = [0.1  0.5  1.0  2  3.4]
%sim.sim_f_oxi = [0.5620  0.5  0.42 0.2  0.05]   
f_gly =  2.0 +  2.0 * tmp.^4./(tmp.^4 + 6^4);
f_oxi =  0.2 - (0.18) * tmp.^4./(tmp.^4 + 6^4);

figure(1)
cells = 1:Nc;
subplot(2,2,1)
plot(cells, f_gly/3.4, 'ks-'), hold on
plot(cells, f_oxi/0.562, 'bs-'), hold off
legend({'Glycolysis', 'OXPHOS'})
xlabel('Cell <i>')

subplot(2,2,2)
plot(cells*15, f_gly, 'ks-'), hold on
plot(cells*15, f_oxi, 'bs-'), hold off
legend({'Glycolysis', 'OXPHOS'})
xlabel('Distance blood vessel [µm]')

subplot(2,2,3)
plot(sim.sim_f_gly, 'ks-'), hold on
plot(sim.sim_f_oxi, 'bs-'), hold off
legend({'Glycolysis', 'OXPHOS'})
xlabel('Distance blood vessel [µm]')


return

sim.glc_ext = [0.8 1.8 5.5 16.5];
sim.o2_ext =  [15 30 120] * 1.3/760;
sim.lac_ext = [1.4];

% Run the variable strategies
if (1)
    disp('*** Running Variable Strategies ***')
    for kgly=1:numel(sim.glc_ext)
        for ko2=1:numel(sim.o2_ext)
            c_ext0 = [sim.glc_ext(kgly), sim.lac_ext(1), sim.o2_ext(ko2)]
            sim_variable_strategies(c_ext0, f_gly, f_oxi);
        end
    end
end


%{
% Create the figures for the core strategies
if (1)
    disp('*** Creating Figures Core Strategies ***')
    for kgly=1:numel(sim.glc_ext)
        for ko2=1:numel(sim.o2_ext)
            c_ext0 = [sim.glc_ext(kgly), sim.lac_ext(1), sim.o2_ext(ko2)]
            fig_sim_core_strategies(c_ext0);
        end
    end
end
%}
