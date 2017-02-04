function [w, b] = LSRL2(traindata, trainlabels, lambda)
    % INPUT : 
    % traindata   - m X n matrix, where m is the number of training points
    % trainlabels - m X 1 vector of training labels for the training data
    % lambda       - regularization parameter (positive real number)
        
    % OUTPUT
    % returns learnt model: w - n x 1 weight vector, b - bias term
    
    % Fill in your code here
    
    [m,n] = size(traindata);
    X = [traindata,ones(size(traindata,1),1)];
    y = trainlabels;
    R = eye(n);
    R = [R,zeros(n,1)];
    R = [R;zeros(1,n+1)];
    W = pinv(X'*X + lambda*m*R) * X' * y;
    w = W(1:end-1);
    b = W(end);
end
