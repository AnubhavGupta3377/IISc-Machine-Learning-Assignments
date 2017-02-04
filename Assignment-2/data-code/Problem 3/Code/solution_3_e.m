traindata = importdata('../Spambase/train.txt');
X_train = traindata(:,1:end-1);
y_train = traindata(:,end);
testdata = importdata('../Spambase/test.txt');
X_test = testdata(:,1:end-1);
y_test = testdata(:,end);

trainerror = [];
testerror = [];
lambdas = [0.0000001, 0.000001, 0.00001, 0.0001, 0.001, 0.01, 0.1, 1];
for i = 1:8
    lambda = lambdas(i);
    [w,b] = LogisticRegressionL2(X_train,y_train,lambda);
    B = b*ones(size(X_train,1),1);
    y_pred = sign(X_train * w + B);
    trainerror = [trainerror, classification_error(y_pred, y_train)];
    B = b*ones(size(X_test,1),1);
    y_pred = sign(X_test * w + B);
    testerror = [testerror, classification_error(y_pred, y_test)];
end
figure;
semilogx(lambdas,trainerror,lambdas,testerror,'LineWidth',2);
title('Lambda vs Training and Test error');
xlabel('Value of Lambda');
ylabel('Classification Error');
legend('Training Error','Test Error');

error = [];
lambdas = [0.00001,0.0001,0.001,0.01, 0.1, 1, 10,100];
for i = 1:8
    lambda = lambdas(i);
    cverror = 0;
    for fold = 1:5
        training = load(sprintf('../Spambase/CrossValidation/Fold%d/cv-train.txt',fold));
        X_train = training(:,1:end-1);
        y_train = training(:,end);
        testing = load(sprintf('../Spambase/CrossValidation/Fold%d/cv-test.txt',fold));
        X_test = testing(:,1:end-1);
        y_test = testing(:,end);
        [w,b] = LogisticRegressionL2(X_train,y_train,lambda);
        B = b*ones(size(X_test,1),1);
        y_pred = sign(X_test * w + B);
        cverror = cverror + classification_error(y_pred, y_test);
    end
    error = [error,cverror/5];
end
error

% trainerror = [0.0240, 0.0240, 0.0240, 0.0240, 0.0200, 0.0240, 0.0240, 0.0720]

% testerror = [0.1078, 0.1078, 0.1078, 0.1078, 0.1083, 0.1066, 0.1053, 0.1209]

% cverror = [0.0760, 0.0760, 0.0760, 0.0840, 0.0880, 0.1200, 0.3960, 1.0000]