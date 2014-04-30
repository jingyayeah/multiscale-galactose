% Create matlab code directly from the SBML and simulate
% Use the Frank Bergmann SBML -> matlab converter
x0 = Galactose_v13_Nc1_Nf1;
[t,x] = ode23s(@Galactose_v13_Nc1_Nf1, [0 100], Galactose_v13_Nc1_Nf1);
plot (t,x);
