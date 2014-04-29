function [] = writeCSVResult(fname, t, x, p)

% Add the time column to the headers and CSV
headers = cell(numel(p.x_ids)+1, 1);
headers{1,1} = 'time';
for k=1:numel(p.x_ids)
    headers{1+k,1} = p.x_ids{k};
end
headers

% Add the time column to the data
csv_data = [t x];

% Creates 
csvwrite_with_headers(fname, csv_data, headers)

end