function label = get_label(t)

data = load('../Data/data.txt');
labels = data(:,3);
if(t > length(labels))
    fprintf('Error: argument exceeds stream size\n');
    return;
end
label = labels(t, :);
end