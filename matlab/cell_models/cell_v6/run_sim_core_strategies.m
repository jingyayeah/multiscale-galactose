sim.glc_ext = [0.8 1.8 5.5 16.5];
sim.o2_ext =  [30 120] * 1.3/760;
sim.lac_ext = [1.4];

% Run the core strategies
if (1)
    disp('*** Running Core Strategies ***')
    for kgly=1:numel(sim.glc_ext)
        for ko2=1:numel(sim.o2_ext)
            c_ext0 = [sim.glc_ext(kgly), sim.lac_ext(1), sim.o2_ext(ko2)]
            sim_core_strategies(c_ext0);
        end
    end
end

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

% Create the overview pictures for the core strategies
fig_sim_core_strategies_sum(sim.glc_ext, sim.o2_ext, sim.lac_ext)





