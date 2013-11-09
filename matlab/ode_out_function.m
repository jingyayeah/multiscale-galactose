function [y] = ode_out_function(t, y, flag, p)
%% ODE_OUT_FUNCTION - Function called after every succesful integration
%   step.
%   Matthias Koenig (2013-08-23)
%   Copyright © Matthias König 2013 All Rights Reserved.

   y = fzero(@poly,x0);
   function y = poly(x)
        y = x^3 + b*x + c;
   end


fprintf('time [s] : %2.2f\n', t)
end