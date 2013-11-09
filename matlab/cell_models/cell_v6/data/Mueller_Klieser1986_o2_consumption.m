function [glc, o2c, o2c_sd] = Mueller_Klieser1986_o2_consumption(o2)
% Returns viabble rim depending on the o2 concentration

% o2 consumption [5% O2]			
% glc [mM]	O2 consumption Q x 10⁴ [cm³ o2/cm³/s]	o2c +-s.d [µm]	+-s.d.
data1 = [
0.8	4.42605	4.65534	0.22929
1.8	3.3914	3.88826	0.49686
5.5	1.65495	1.82066	0.16571
16.5	1.4092	1.6386	0.2294
];

% o2 consumption [20% O2]			
% glc [mM]	viable rim thickness [µm]	o2c +-s.d [µm]	+-s.d.
data2 = [
0.8	5.69985	5.98022	0.28037
1.8	4.80533	4.97093	0.1656
5.5	3.00535	3.31108	0.30573
16.5	3.00158	3.21825	0.21667
];

if (o2 == 5)
    data = data1;
elseif (o2 == 20)
    data = data2;
end

glc = data(:,1);
o2c = data(:,2);
o2c_sd = data(:,4);

end