ode.Nc = 5;
ode.Nf = 5;
ode.Nxout = 3;
ode.Nxin = 82;

ode.ft_ext = [1 1 1];
ode.delta_t = [0.0 1E5];
ode.ext_constant = 0;
ode.ode_cells = 1;
ode.ode_diffusion = 1;
ode.ode_blood = 0;
ode.f_gly = ones(Nc, 1)* 9.0;
ode.f_oxi = ones(Nc, 1)* 2.0;
ode.c_ext0 = [5.5 2.0 10.4];

fid = fopen('ode_settings_test.dat', 'w+');
create_fortran_settings(ode, fid)