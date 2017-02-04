function x = get_instance(t)

data = load('../Data/data.txt');
instances = data(:,1:2);
if(t > length(instances))
    fprintf('Error: argument exceeds stream size\n');
    return;
end
x = instances(t, :);

end