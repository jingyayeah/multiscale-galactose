function [dist, po2] = Mueller_Klieser1986_po2_300()
% Spheroid (diameter 276µm)
% Distance Center [µm] | pO2 [mmHg] | Distance Blood Vessel [µm]	
data = [
376.92	44.00	-100.92
333.80	40.16	-57.80
311.05	37.52	-35.05
296.70	34.17	-20.70
284.75	30.82	-8.75
276.00	29.15	0.00
266.82	26.28	9.18
258.54	17.44	17.46
235.86	8.59	40.14
213.17	1.42	62.83
191.59	0.93	84.41
164.01	0.20	111.99
0.00	0.0	276.00
];

% all data (with diffusion area around spheroid)
%dist = data(:,3);
%po2 = data(:,2);

% only data from surface
pos_ind = data(:,3)>=0;
dist = data(pos_ind,3);
po2 = data(pos_ind,2);


end