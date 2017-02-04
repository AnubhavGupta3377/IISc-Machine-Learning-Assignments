function x = get_instance(s, t)
    if(s == 1)
        load('data_stream_1.mat');
        if(t > size(data1, 1))
            fprintf('Error: Second argument exceeds stream size\n');
            return;
        end
        x = data1(t, :);
    elseif(s == 2)
        load('data_stream_2.mat');        
        if(t > size(data2, 1))
            fprintf('Error: Second argument exceeds stream size\n');
            return;
        end
        x = data2(t, :);        
    elseif(s == 3)
        load('data_stream_3.mat');        
        if(t > size(data3, 1))
            fprintf('Error: Second argument exceeds stream size\n');
            return;
        end
        x = data3(t, :);       
    else
        fprintf('Error: Incorrect value for the first argument s\n');
    end    
end