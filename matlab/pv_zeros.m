function [y_pv] = pv_zeros(t, p)
%% PV_ZEROS - Sets perivenious time course to zero.

%   Matthias Koenig (2013-08-23)
%   Copyright � Matthias K�nig 2013 All Rights Reserved.

y_pv = zeros(p.Nx_out, numel(t));

end