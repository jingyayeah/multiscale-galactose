% Create matlab code directly from the SBML and simulate
% Use the Frank Bergmann SBML -> matlab converter
x0 = Galactose_Dilution_v3_Nc1_Nf1_fixed;
[t,x] = ode23s(@Galactose_Dilution_v3_Nc1_Nf1_fixed, [0 100], x0);
plot (t,x);