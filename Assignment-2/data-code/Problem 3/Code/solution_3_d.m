trainerror = [];
testerror = [];
subsets = [10,20,30,40,50,60,70,80,90,100];
testdata = importdata('../Spambase/test.txt');
X_test = testdata(:,1:end-1);
y_test = testdata(:,end);
for i = 1:10
    training = load(sprintf('../Spambase/TrainSubsets/train-%d%%.txt',subsets(i)));
    X_train = training(:,1:end-1);
    y_train = training(:,end);
    [w,b] = LogisticRegression(X_train,y_train);
    B = b*ones(size(X_train,1),1);
    y_pred = sign(X_train * w + B);
    trainerror = [trainerror, classification_error(y_pred, y_train)];
    B = b*ones(size(X_test,1),1);
    y_pred = sign(X_test * w + B);
    testerror = [testerror, classification_error(y_pred, y_test)];
end
figure;
plot(subsets,trainerror,subsets,testerror,'LineWidth',2);
title('Learning Curve of Logistic Regression');
xlabel('Fraction of training examples (%)');
ylabel('Classification error');
legend('Training Error','Test Error');

% Initial W = zeros(d,1) and initial b = 0