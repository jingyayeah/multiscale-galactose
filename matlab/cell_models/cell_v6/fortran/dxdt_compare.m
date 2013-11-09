clc
clear all
sim_bloodflow;
load('/fortran/test.dat')


% relative difference 
dif1 = (test-res)./test;
dif2 = (test-res)./res;

% remove the Inf, -Inf, NaN
dif1(dif1==Inf) = 0;
dif1(dif1==-Inf) = 0;
dif1(isnan(dif1)) = 0;

dif2(dif2==Inf) = 0;
dif2(dif2==-Inf) = 0;
dif2(isnan(dif2)) = 0;

index = [1:size(dif1,1)]';



format short
disp('-------------------------------')
tmp = [ index test(:,1) res(:,1) test(:,2) res(:,2)]
disp('-------------------------------')
dif = [ index dif1 dif2]
disp('-------------------------------')
%{
disp('Difference in concentrations')
find(dif(:,1)) > 1E-2
disp('Difference in dxdt')
find(dif(:,2)) > 1E-2
%}

offset = p.Nx_out + p.Nf*p.Nx_out - p.Nx_out
tol = 1E-2;
in1 = find(abs(dif1(:,2))>tol);
in2 = find(abs(dif2(:,2))>tol);
if (length(in1) > 0)
    in1 = in1-offset;
end
if (length(in2) > 0)
    in2 = in2-offset;
end

in1
in2