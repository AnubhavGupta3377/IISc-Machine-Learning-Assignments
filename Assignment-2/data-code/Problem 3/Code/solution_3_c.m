traindata = importdata('../Spambase/train.txt');
X_train = traindata(:,1:end-1);
y_train = traindata(:,end);
testdata = importdata('../Spambase/test.txt');
X_test = testdata(:,1:end-1);
y_test = testdata(:,end);
[w,b] = LogisticRegression(X_train,y_train);
B = b*ones(size(X_train,1),1);
y_pred = sign(X_train * w + B);
train_error = classification_error(y_pred, y_train)
B = b*ones(size(X_test,1),1);
y_pred = sign(X_test * w + B);
test_error = classification_error(y_pred, y_test)

% Initial W = zeros(d,1) and initial b = 0
% train_error = 0.0240
% test_error = 0.1078