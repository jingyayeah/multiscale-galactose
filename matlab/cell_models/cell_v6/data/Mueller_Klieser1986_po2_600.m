function [dist, po2] = Mueller_Klieser1986_po2_600()
% Spheroid (diameter 597µm)
% Distance Center [µm] | pO2 [mmHg] | Distance Blood Vessel [µm]	
data = [
703.05	144.93	-106.05
652.77	137.74	-55.77
618.13	126.74	-21.13
597.00	114.08	0.00
575.42	89.47	21.58
545.76	62.71	51.24
523.20	44.07	73.80
495.81	29.01	101.19
446.86	11.32	150.14
386.99	4.13	210.01
299.47	1.00	297.53
199.95	0.00	397.05
0.00	0.00	597.00
];

dist = data(:,3);
% all data (with diffusion area around spheroid)
%dist = data(:,3);
%po2 = data(:,2);

% only data from surface
pos_ind = data(:,3)>=0;
dist = data(pos_ind,3);
po2 = data(pos_ind,2);

end
