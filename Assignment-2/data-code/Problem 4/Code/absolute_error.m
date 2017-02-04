function err = absolute_error(y_pred, y_true)
% This function computes the error for the predicted ratings
% with respect to the ground truth. The returned error value is a real number
% between 0 and 4 (absolute difference).

% y_true: vector of true ratings
% y_pred: vector of predicted labels
% err:  error (absolute difference)

	err = sum(abs(y_true - y_pred))/length(y_true);
end
