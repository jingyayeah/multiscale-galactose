function [dydt, V_names, V] = dydt_cellsimple(t, y, p)
% Calculates dydt for single cell
% Layout information given in the pars structure p.
%   author: Matthias Koenig
%           [matthias.koenig[at]charite.de]
%   date: 121015
%
%   Fluxes are handled in respect of the cell Volume. Therefore, the
%   exchange fluxes are modified with p.Vol_cell/p.Vol_blood;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dydt    = zeros(p.Nx_out*p.Nf + p.Nx_in,1);

% External concentrations
glc_ext = y(       1:  p.Nf);
lac_ext = y(  p.Nf+1:2*p.Nf);
o2_ext  = y(2*p.Nf+1:3*p.Nf);

% Internal concentrations (vector for cells)
glc     = y(p.Nx_out*p.Nf + 1);
lac     = y(p.Nx_out*p.Nf + 2);
o2      = y(p.Nx_out*p.Nf + 3);
atp     = y(p.Nx_out*p.Nf + 4);
adp     = y(p.Nx_out*p.Nf + 5);
pyr     = y(p.Nx_out*p.Nf + 6);

% Vectorized internal concentrations
onevec = ones(size(glc_ext));
glc_in = glc*onevec;
lac_in = lac*onevec;
o2_in  = o2 *onevec;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fscale = 1;

phi = 0.5;

vmax = fscale * [   5                % [1] GLUT1
                    20                % [2] DO2
                    0.1                % [3] MCT1
                    0.1                 % [4] MCT4
                    0.1                 % [5] LDHA
                    0.1                 % [6] LDHB
                    
                    0.2                    % [7] ATPASE
                    0.2   * phi            % [8] GLY
                    0.8  * (1 -phi) ];    % [9] OX

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Induction and repression (HIF effect on the different enzymes)
% TODO: implement induction and repression dependent on O2
infac  = 1;
repfac = 1;                               

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % [1] v_glut1 (glc_ext -> glc) [import]
  v_glut1_out = vmax(1)/p.Nf * (glc_ext - glc_in)./ ...
                            (onevec + glc_ext/1.0 + glc_in/1.0);
  v_glut1_in = sum(v_glut1_out);

  % [2] o2 transport (o2_ext -> o2) [import diffusion]
  v_do2_out = vmax(2)/p.Nf * (o2_ext - o2_in);
  v_do2_in  = sum(v_do2_out);
  
  % [3] v_mct1 (lac_ext -> lac) [import]
  v_mct1_out = vmax(3)*infac/p.Nf * (lac_ext - lac_in/5.0)./ ...
            (onevec + lac_ext/6.0 + lac_in/6.0);
  v_mct1_in  = sum(v_mct1_out);
  
  % [4] v_mct4 (lac_ext -> lac) [export]
  v_mct4_out = vmax(4)*repfac/p.Nf * (lac_ext - lac_in/0.2)./ ...
            (onevec + lac_ext/30.0 + lac_in/30.0);
  v_mct4_in  = sum(v_mct4_out);
  
  % [5] v_ldha (lac -> pyr) [export pyr -> lac]
  % more in the direction of pyruvate
  v_ldha = vmax(5)*repfac * (lac - pyr/0.2) / (lac + 6.88);
                        
  % [6] v_ldhb (lac -> pyr) [import lac -> pyr]
  % more in the direction of lactate
  v_ldhb = vmax(6)*infac*(lac - pyr/5) / (lac + 3.95);
  
  
  % The following reactions are irreversible 
  % [7] v_atpase - ATP consumption (1 atp -> 1 adp + 1 p)
  v_atpase = vmax(7) * atp/(atp + 1.0);
  %v_atpase = max(0, v_atpase);
  
  % [8] v_anaerob (1 glc + 2ADP + 2P -> 2 ATP + 2 pyr)
  v_anaerob = vmax(8)/2 *infac* glc/(glc + 0.05) * adp/(adp + 0.25);
  %v_anaerob = max(0, v_anaerob);
  
  % [9] v_aerob (2 pyr + 12 o2 + 30 adp + 30 p -> 30 atp)
  v_aerob = vmax(9)/30 * repfac * pyr/(pyr + 0.04) * ... 
                             adp/(adp + 0.1)  * ...
                             o2/ (o2 + 0.001);
                         
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % CHANGES DUE TO CELLS
  % [extern]
  % glc_ext
  dydt(       1:  p.Nf) = - v_glut1_out * p.Vol_cell/p.Vol_blood;
  % lac_ext
  dydt(  p.Nf+1:2*p.Nf) = - (v_mct1_out + v_mct4_out) * p.Vol_cell/p.Vol_blood;
  % o2_ext
  dydt(2*p.Nf+1:3*p.Nf) = - v_do2_out * p.Vol_cell/p.Vol_blood;

  % [intern]
  % glc
  dydt(p.Nx_out*p.Nf + 1) = v_glut1_in - v_anaerob;
  % lac
  dydt(p.Nx_out*p.Nf + 2) = v_mct1_in + v_mct4_in - v_ldha - v_ldhb;
  % o2
  dydt(p.Nx_out*p.Nf + 3) = v_do2_in - 12*v_aerob;
  % atp  
  dydt(p.Nx_out*p.Nf + 4) =  2*v_anaerob + 30*v_aerob - v_atpase;
  % adp
  dydt(p.Nx_out*p.Nf + 5) = -2*v_anaerob - 30*v_aerob + v_atpase;
  % pyr
  dydt(p.Nx_out*p.Nf + 6) =  2*v_anaerob - 2*v_aerob + v_ldha + v_ldhb;
  
  %disp('cellsimple_v3_dydt changes:')
  %res = [y, dydt]
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargout > 1
    V_names{1} = 'v_gly';    V(1) = v_anaerob;
    V_names{2} = 'v_ox';      V(2) = v_aerob;
    V_names{3} = 'v_atpase';     V(3) = v_atpase;
    V_names{4} = 'v_ldha';       V(4) = v_ldha;
    V_names{5} = 'v_ldhb';       V(5) = v_ldhb;
    
    V_names{6} = 'v_mct1_in';    V(6) = v_mct1_in;  
    V_names{7} = 'v_mct4_in';    V(7) = v_mct4_in;
    V_names{8} = 'v_glut1_in';   V(8) = v_glut1_in;
    V_names{9} = 'v_o2t_in';     V(9) = v_do2_in;    
end 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%