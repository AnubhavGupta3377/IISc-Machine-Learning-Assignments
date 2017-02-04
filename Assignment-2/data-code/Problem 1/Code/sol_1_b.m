traindata = importdata('../Dataset-2/train.txt');
X_train = traindata(:,1:end-1);
y_train = traindata(:,end);
testdata = importdata('../Dataset-2/test.txt');
X_test = testdata(:,1:end-1);
y_test = testdata(:,end);

trainerror = [];
testerror = [];
lambdas = [0.00001,0.0001,0.001,0.01, 0.1, 1, 10,100];
for i = 1:8
    lambda = lambdas(i);
    [w,b] = LSRL2(X_train,y_train,lambda);
    y_pred_train = X_train*w + b*ones(size(X_train,1),1);
    trainerror = [trainerror, mean_squared_error(y_pred_train, y_train)];
    y_pred_test = X_test*w + b*ones(size(X_test,1),1);
    testerror = [testerror, mean_squared_error(y_pred_test, y_test)];
end
figure;
semilogx(lambdas,trainerror,lambdas,testerror,'LineWidth',2);
title('Lambda vs Training and Test error');
xlabel('Value of Lambda');
ylabel('Mean Squared Error');
legend('Training Error','Test Error');

error = [];
lambdas = [0.00001,0.0001,0.001,0.01, 0.1, 1, 10,100];
for i = 1:8
    lambda = lambdas(i);
    cverror = 0;
    for fold = 1:5
        training = load(sprintf('../Dataset-2/CrossValidation/Fold%d/cv-train.txt',fold));
        X_train = training(:,1:end-1);
        y_train = training(:,end);
        testing = load(sprintf('../Dataset-2/CrossValidation/Fold%d/cv-test.txt',fold));
        X_test = testing(:,1:end-1);
        y_test = testing(:,end);
        [w,b] = LSRL2(X_train,y_train,lambda);
        y_pred = X_test*w + b*ones(size(X_test,1),1);
        cverror = cverror + mean_squared_error(y_pred,y_test);
    end
    error = [error,cverror/5];
end
error

% error = [622.2195,622.2151,622.1727,621.8743,626.5918,731.9716,1113.9912,1779.5625]