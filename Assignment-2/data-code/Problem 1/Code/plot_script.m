%%Plot least squares regression%%
function plot_script(x_test, y_test, y_test_pred)

% This function is used to visualize least squares regression. It plots
% the true test labels,
% and the predictions produced by regression.
% Note that the arguement 

% x_test - 900 x 1 vector of test instances 
% y_test - 900 x 1 vector of real labels
% y_test_pred - 900 x 1 vector of label predictions 



plot(x_test,y_test,'r.');

hold on;

plot(x_test,y_test_pred ,'b-');

legend('True labels','Predicted labels')
xlabel('x')
ylabel('y')