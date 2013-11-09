function [] = create_fortran_settings(ode, fname)
% Creates a fortran settings file fid with the given
% ode options in the struct

fid = fopen(fname, 'w+');
cdata = clock;

fprintf(fid, '####################################################\n');
fprintf(fid, '#     ODE Settings LIMEX Integration\n');
fprintf(fid, '####################################################\n');
fprintf(fid, '#     author : Matthias Koenig                     \n');
fprintf(fid, '#     time   : %u|%02u|%02u  %02u:%02u\n', cdata(1:5) );
fprintf(fid, '#     Nc = %u\n', ode.Nc);
fprintf(fid, '#     Nf = %u\n', ode.Nf);
fprintf(fid, '#     Nxout = %u\n', ode.Nx_out); 
fprintf(fid, '#     Nxin = %u\n', ode.Nx_in);
fprintf(fid, '####################################################\n');
fprintf(fid, '# c_ext0 # \n');
fprintf(fid, '%E ', ode.c_ext0);
fprintf(fid, '\n');
fprintf(fid, '# ft_ext #\n');
fprintf(fid, '%u ', ode.ft_ext);
fprintf(fid, '\n');

fprintf(fid, '# delta_t #\n');
fprintf(fid, '%E %E', ode.delta_t(1), ode.delta_t(2));
fprintf(fid, '\n');

fprintf(fid, '# extconstant, odecells, odediffusion, odeblood #\n');
fprintf(fid, '%u %u %u %u', ode.ext_constant, ode.ode_cells, ode.ode_diffusion, ode.ode_blood);
fprintf(fid, '\n');

fprintf(fid, '# f_gly #\n');
fprintf(fid, '%E ', ode.f_gly);
fprintf(fid, '\n');

fprintf(fid, '# f_oxi #\n');
fprintf(fid, '%E ', ode.f_oxi);
fprintf(fid, '\n');
fprintf(fid, '####################################################\n');

end
