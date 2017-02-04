function [w, b] = LogisticRegression(traindata, trainlabels)
    % INPUT : 
    % traindata   - m X n matrix, where m is the number of training points
    % trainlabels - m X 1 vector of training labels for the training data    
    
    % OUTPUT
    % returns learnt model: w - n x 1 weight vector, b - bias term
    
    % Fill in your code here    
    % Consider using fminunc MATLAB function for solving the logistic regression optimization problem.
    
    [m,n] = size(traindata);
    X = [traindata,ones(size(traindata,1),1)];
    y = trainlabels;
    fun = @(W)sum(log(exp(-y.*(X*W)) + ones(m,1)));
    W0 = zeros(n+1,1);
    [W,fval] = fminunc(fun,W0);
    w = W(1:end-1);
    b = W(end);
end
