function [] = createCSV(fname, t, x, p)
%% Creates a csv file storing the results.
% Important for model comparison with java & cpp.

fid = fopen(fname,'w');

Nt = numel(t);
Nx = size(x, 2);

% create proper header file for the simulation
% the file has to have the same headers like the java/cpp generated files
%% TODO: create the correct names of the variables




% write header
fprintf(fid, 'time\t');
for kx=1:Nx-1
    fprintf(fid, 'x%s\t', num2str(kx));
end
fprintf(fid, 'x%s\n', num2str(Nx));

% write data
for kt=1:Nt
    fprintf(fid, '%f\t', t(kt));
    for kx=1:Nx-1
        fprintf(fid, '%f\t', x(kt, kx));
    end
    fprintf(fid, '%f\n', x(kt, kx));
end
fclose(fid);

sprintf('CSV file generated: %s', fname')

end