n = 1000;
Y = [];
Y_pred = [];
errors = [];
examples = [];
w = zeros(2,1);
b = [0,0,0,0,inf];
yt = ones(4,1);
tout = zeros(4,1);
y_pred = 1;
count = 0;
for i = 1:n
    x = get_instance(i)';
    for r = 1:5
        if x'*w - b(r) < 0
            y_pred = r;
            break
        end
    end
    y = get_label(i);
    Y = [Y;y];
    Y_pred = [Y_pred;y_pred];
    errors = [errors;absolute_error(Y_pred,Y)];
    if y ~= y_pred
        for r = 1:4
            if y <= r
                yt(r) = -1;
            else
                yt(r) = 1;
            end
        end
        for r = 1:4
            if (x'*w - b(r))*yt(r) <= 0
                tout(r) = yt(r);
            else
                tout(r) = 0;
            end
        end
        w = w + sum(tout)*x;
        for r = 1:4
            b(r) = b(r) - tout(r);
        end
    else
        count = count+1;
    end
    
    examples = [examples;i];
end

figure;
plot(examples,errors,'b-')
title('Performance of Multiclass Perceptron for Ranking');
xlabel('Number of examples seen');
ylabel('Absolute error divided by number of examples seen');