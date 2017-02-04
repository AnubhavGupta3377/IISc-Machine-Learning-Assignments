function [w, b] = LSR(traindata, trainlabels)
    % INPUT : 
    % traindata   - m X n matrix, where m is the number of training points
    % trainlabels - m X 1 vector of training labels for the training data    
    
    % OUTPUT
    % returns learnt model: w - n x 1 weight vector, b - bias term
    
    % Fill in your code here
    
    X = [traindata,ones(size(traindata,1),1)];
    y = trainlabels;
    W = pinv(X'*X) * X' * y;
    w = W(1:end-1);
    b = W(end);
end
