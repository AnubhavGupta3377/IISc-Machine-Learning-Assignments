function [w,mistakes,bounds,totalMistakes] = winnow(s,n)
    X = [];
    y = [];
    totalMistakes = 0;
    if (s == 1 || s == 2)
        bounds = [];
        norms = [];
        temp = [];
        w_opt = [0, 1/sqrt(2), -1/sqrt(2)];
    else
        bounds = [];
    end
    for i = 1:n
        % Augmenting X
        X = [X;[1,get_instance(s,i)]];
        y = [y;get_label(s,i)];
    end

    mistakes = [];
    w = (size(X,2) * ones(1,size(X,2))) / size(X,2);
    errors = 0;
    for i = 1:n
        if y(i)*X(i,:)*w' <= 0
            errors = errors + 1;
            totalMistakes = totalMistakes + 1;
            exponential = exp(y(i)*X(i,:));
            z = norm(w .* exponential, 1);
            w = (w .* exponential) / z;
        end
        if (s == 1 || s == 2)
            temp = [temp;y(i)*X(i,:)*w_opt'];
            norms = [norms;norm(X(i,:),inf)];
            bounds = [bounds;4*(max(norms)^2)*log(size(X,2)) / (min(temp)^2)];
        end
        mistakes = [mistakes;errors/i];
    end
end