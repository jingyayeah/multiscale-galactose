function [] = fig_model_settings(p)
% Generates basic system analysis based on the parameter structure for the 
% system.

    figure('Name','Initial concentrations');
    % Initial concentrations of full model (blood and cells)
    subplot(2,2,1)
    plot(p.x0, 'ko-')
    title('Model : Initial concentrations');
    axis square

    % Initial concentrations of single cell
    subplot(2,2,2)
    plot(p.x0(p.Nx_out+1:p.Nx_out+p.Nxc), 'ko-')
    title('Cell : Initial concentrations');
    axis square
   
    % JPattern of the system
    if (isfield(p, 'JPattern'))
        subplot(2,2,3)
        colormap('gray');
        J = p.JPattern;

        p1 = pcolor(full(J));
        set(p1, 'EdgeAlpha', 0);
        title('JPattern')
        axis square
        axis ij
        ylabel('dxdt')
        xlabel('x')
        colorbar()
    end
    drawnow
    
end