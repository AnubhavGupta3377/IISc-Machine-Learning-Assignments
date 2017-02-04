function err = mean_squared_error(y_pred, y_true)
% This function computes the mean squared error for the predicted labels
% with respect to the ground truth.

% y_true: m x 1 vector of true labels (in R)
% y_pred: m x 1 vector of predicted labels (in R)
% err: mean squared error

    err = mean((y_pred - y_true).^2);
end
