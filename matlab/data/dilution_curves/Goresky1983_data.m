function [x, y] = Goresky1983_data(compound)
%% Villeneuve_data : multiple indicator dilution data.
% Kinetic.Interpretation.of.Hepatic.Multiple-indicator.Dilution.Studies_Goresky1983

% compound can be
%   RBC
%   Albumin
%   Sucrose
%   Na
%   Water
fprintf('Goresky1983_data: compound=%s\n', compound)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1000 outflow fraction/ml				
switch compound
    case 'RBC'
        data = [   
%time [sec]	RBC
1.5834284	0.17678298
3.0903099	6.3591857
4.9766455	14.288503
6.684267	9.0576725
8.357989	4.2411547
9.95251	2.324096
14.274445	0.41749522

        ];
        x = data(:,1);
        y = data(:,2);
        clear data

    case 'Albumin'
        data = [           
% time [sec]	T-1824
3.099058	1.1821908
5.053661	5.406795
6.586787	7.7006087
8.470467	6.702567
10.070298	5.1766315
11.708715	3.5814924
14.881977	1.4961078
20.755629	0.34165314

        ];
        x = data(:,1);
        y = data(:,2);
        clear data
        
    case 'Sucrose'
        data = [      
% time [sec]	Sucrose
3.1668568	0.35356596
6.666927	4.870171
8.42407	6.196589
10.038274	5.728987
11.645916	4.778233
13.526158	3.5271115
15.055067	2.5997283
16.74488	1.878683

        ];
        x = data(:,1);
        y = data(:,2);
        clear data
        
     case 'Na'
        data = [      
% time [sec]	Na
3.0884352	0.39994422
6.666927	4.870171
8.42407	6.196589
10.038274	5.728987
11.645916	4.778233
13.526158	3.5271115
15.055067	2.5997283
16.74488	1.878683
        ];
        x = data(:,1);
        y = data(:,2);
        clear data
        
    case 'Water'
        data = [
% time [sec]	Water
4.9024415	0.09248369
6.605377	0.3377428
8.307688	0.5369874
9.9711	0.7824284
11.594676	1.005044
13.33776	1.2961358
15.000235	1.472555
16.741756	1.6486105
18.365957	1.9172406
20.06608	1.9554344
21.726055	1.9477956
23.42618	1.9859896
25.004921	1.8176638
        ];
        x = data(:,1);
        y = data(:,2);
        clear data
end
end
									