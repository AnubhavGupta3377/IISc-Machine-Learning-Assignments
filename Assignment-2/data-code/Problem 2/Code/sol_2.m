traindata = importdata('../Data/train.txt');
X_train = traindata(:,1:end-1);
y_train = traindata(:,end);
testdata = importdata('../Data/test.txt');
X_test = testdata(:,1:end);
[m1,n1] = size(X_train);
K = compute_kernel(X_train,X_train);
C = K + 0.1*eye(m1);
[m2,n2] = size(X_test);
means = [];
sds = [];
for i = 1:m2
    c = compute_kernel(X_test(i,:),X_test(i,:)) + 0.1;
    k = compute_kernel(X_train, X_test(i,:));
    inv_C = inv(C);
    mean = k'*inv_C*y_train;
    sd = sqrt(c - k'*inv_C*k);
    means = [means;mean];
    sds = [sds;sd];
end

plot_script(X_train,y_train,X_test,means,sds);