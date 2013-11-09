function [J_sparse, J, lbw, ubw] = rand_jpattern_generator(p)
% Generate Jpattern based on random method.
% dxdt calculated for slide variations in input vector and the differences
% in dxdt1 - dxdt2 used to create the Jpattern.
% In addition calculates the upper and lower bandwidth from the numerical
% Jacobian.
%
%
%   author: Matthias Koenig
%   date:   111011

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('... calculate random Jpattern ...');

% calculate random references states around initial state
x_ref = p.x0;
Nx = numel(p.x0);   
Nr = 1;                              % number of repetitions
x_refs = zeros(Nr, Nx);
dxdt_refs = zeros(Nr, Nx);
x_refs(1, :) = p.x0;
for k=2:Nr
    x_refs(k, :) = x_refs(k,:).*(rand(1,Nx) + ones(1,Nx));
end
for k=1:Nr
   dxdt_refs(k,:) = p.odefun(0, x_refs(k,:)', p); 
end

J = zeros(numel(x_ref));
tic
for k = 1:Nr 
    for j=1:Nx
        for i=1:3;  % some repetitions with same vector to be sure
            
            % vary one component in x and see if influence
            x_test = x_refs(k, :);
            x_test(j) = x_test(j)*(1+rand(1));
            dxdt_test = p.odefun(0, x_test', p);
        
            % find the differences and count
            I_dif = find(dxdt_refs(k,:)'-dxdt_test~= 0);
            J(I_dif, j) = J(I_dif, j)+1;
        end
    end
end
toc
% 0 or 1 entries and sparsity
J(J>0) = 1;
J_sparse = sparse(J);

% clean the generated fields
%p = rmfield(p, {'odecells', 'odeblood', 'odediffusion', 'extconstant'});

% Calculation of the upper and lower bandwith of the problem
if (nargout > 2)
    % calculate the upper and lower band with
    ubw = zeros(numel(p.x0), 1);
    lbw = zeros(numel(p.x0), 1);
    for k=1:numel(p.x0)
        I = find(J(k,:)~=0);
        ubw(k) = max(I) - k;
        lbw(k) = k - min(I); 
    end
    max_lbw = max(lbw)
    max_ubw = max(ubw)
    if 0
       figure(1)
       subplot(2,1,1)
       plot(1:numel(p.x0), lbw, 'k-o')
       title('Lower Band Width')
       subplot(2,1,2)
       plot(1:numel(p.x0), ubw, 'k-o')
       title('Upper Band Width')
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the resulting Jpattern
if 0
    figure()
    colormap('gray')
    p1  = pcolor(J);
    set(p1, 'EdgeAlpha', 0);
    axis ij
    axis square
    colorbar
    input('continue?')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%