function [f] = tc_generator(modus, par)
%TC_GENERATOR Generates timecourses of metabolite depending on the
% given modus of timecourse and the given m_init parameters.
% Returns function handle to function which calculates the actual value of
% the metabolites depending on time.

%f = [];
switch modus
    case 'constant'
        f = @f_constant;
    case 'gauss'
        f = @f_gauss;
    case 'sinus'
        f = @f_sinus;
    case 'step'
        f = @f_step;
end


    function m = f_constant(t)
    % Constant response over time
        m = par * ones(size(t));
    end
    

    function m = f_gauss(t)
    % Gauss peak over time
        sigma = 10;        % [s] standard deviation
        mu = 100;          % [s] peak location
        m = par * normpdf(t,mu,sigma)/normpdf(mu,mu,sigma);
    end


    function m = f_sinus(t)
    % Sinus response between m_init and m_base
        %f = 0.05;                  % [Hz]
        m = par + 0.5*par*sin(6.2832*0.002*t);
    end

    function m = f_step(t)
    % Stepwise response for certain time
        t_start = 10;    % [s] time until onset
        t_dur = 10;   % [s] duration of step
        t_end = t_start + t_dur;

        % better with logical test
        m = ones(1, length(t));
        for k=1:length(t)
            if t(k) >= t_start && t(k) <= t_end 
                m(k) = par;
            else
                m(k) = 0.0;
            end
        end
    end
end