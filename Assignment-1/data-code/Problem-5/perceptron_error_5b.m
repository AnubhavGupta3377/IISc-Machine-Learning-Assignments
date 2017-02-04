n = 1000;
s = 1;
u = [1/sqrt(2),-1/sqrt(2)];
X = [];
y = [];
for i = 1:n
    X = [X;get_instance(s,i)];
    y = [y;get_label(s,i)];
end
errors = [];
w = zeros(1,size(X,2));
for i = 1:n
    if y(i)*X(i,:)*w' <= 0
        w = w + y(i)*X(i,:);
    end
    errors = [errors;error_uniform(u,w)];
end
plot(1:n, errors);
title('Generalization error of w learned by Perceptron algorithm in each iteration')
ylabel('Expected error of w')
xlabel('Number of examples seen')