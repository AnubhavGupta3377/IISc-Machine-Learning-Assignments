%%Plot gaussian process regression%%
function plot_script(x_train, y_train, x_test, y_test_pred, sigma_test_pred)

% This function is used to visualize gaussain process regression. It plots
% the true x*sin(x) function, noisy train samples drawn from the function,
% and the regression curve produced by gaussian process.
% Note that the arguement 

% x_train - 50 x 1 vector of train instances 
% y_train - 50 x 1 vector of real labels
% x_test -  1000 x 1 vector of test instances
% y_test_pred - 1000 x 1 vector of label predictions produced by gaussian
% process
% sigma_test_pred -  1000 x 1 vector of standard deviations for each test
% predictions




plot(x_train,y_train,'ro');

hold on;

plot(x_test, x_test.*sin(x_test), 'b.',...
    x_test,y_test_pred ,'g-',...
    x_test,y_test_pred - 1.9600 * sigma_test_pred,'k:',...
    x_test,y_test_pred + 1.9600 * sigma_test_pred,'k:');
legend('Train samples','True function f(x) = x*sin(x)', 'Test predictions', '95% confidence interval for test predictions')
xlabel('x')
ylabel('y')