function [glc, rim_d, rim_d_sd] = Mueller_Klieser1986_viable_rim(o2)
% Returns viabble rim depending on the o2 concentration

% viable rim [5% O2]			
% glc [mM]	viable rim thickness [µm]	vrt +-s.d [µm]	+-s.d.
data1 = [
    0.8	66.31377	83.22821	16.91444
    1.8	71.26173	89.3084	18.04667
    5.5	142.14011	153.4201	11.27999
    16.5	263.21127	285.76459	22.55332
];

%viable rim [20% O2]			
%glc [mM]	viable rim thickness [µm]	vrt +-s.d [µm]	+-s.d.
data2 = [
    0.8	113.11655	124.96044	11.84389
    1.8	148.51895	154.7195	6.20055000000002
    5.5	204.73399	222.21678	17.48279
    16.5	251.93349	237.83627	14.09722
];

if (o2 == 5)
    data = data1;
elseif (o2 == 20)
    data = data2;
end

glc = data(:,1);
rim_d = data(:,2);
rim_d_sd = data(:,4);

end