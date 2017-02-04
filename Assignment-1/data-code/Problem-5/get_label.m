function label = get_label(s, t)
    if(s == 1)
        load('data_stream_1.mat');
        if(t > length(labels1))
            fprintf('Error: Second argument exceeds stream size\n');
            return;
        end
        label = labels1(t, :);
    elseif(s == 2)
        load('data_stream_2.mat');        
        if(t > length(labels2))
            fprintf('Error: Second argument exceeds stream size\n');
            return;
        end
        label = labels2(t, :);
    elseif(s == 3)
        load('data_stream_3.mat');        
        if(t > length(labels3))
            fprintf('Error: Second argument exceeds stream size\n');
            return;
        end
        label = labels3(t, :);
    else
        fprintf('Error: Incorrect value for the first argument s\n');
    end
end