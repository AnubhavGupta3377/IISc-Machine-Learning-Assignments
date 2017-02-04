path = sprintf('/home/anubhav/Desktop/Link to Machine Learning/Assignments/hw1-data-code/Problem-6/');

training = load(strcat(path,'Spambase/train.txt'));
traindata = training(:,1:size(training,2)-1);
trainlabels = training(:,size(training,2));
testing = load(strcat(path,'Spambase/test.txt'));
testdata = testing(:,1:size(testing,2)-1);
testlabels = testing(:,size(testing,2));

set(0,'defaultAxesFontSize', 16);

trainerror = [];
testerror = [];
kerneltype = 'linear';
C = [1,10,100,1000,10000];
for i = 1:5
    c = C(i);
    model = SVM_learner(traindata,trainlabels,c,kerneltype,1);
    trlabels = SVM_classifier(traindata,model);
    telabels = SVM_classifier(testdata,model);
    trainerror = [trainerror,classification_error(trlabels,trainlabels)];
    testerror = [testerror,classification_error(telabels,testlabels)];
end
figure;
semilogx(C,trainerror,C,testerror,'LineWidth',2);
title('C vs Training and Test error');
xlabel('Value of C');
ylabel('Error');
legend('Training Error','Test Error');

% C = 1000 minimizes test error. Minimum test error = 0.1083


error = [];
kerneltype = 'linear';
C = [1,10,100,1000,10000];

for i = 1:5
    c = C(i);
    cverror = 0;
    for fold = 1:5
        training = load(strcat(path,sprintf('Spambase/CrossValidation/Fold%d/cv-train.txt',fold)));
        traindata = training(:,1:size(training,2)-1);
        trainlabels = training(:,size(training,2));
        testing = load(strcat(path,sprintf('Spambase/CrossValidation/Fold%d/cv-test.txt',fold)));
        testdata = testing(:,1:size(testing,2)-1);
        testlabels = testing(:,size(testing,2));
        model = SVM_learner(traindata,trainlabels,c,kerneltype,1);
        labels = SVM_classifier(testdata,model);
        cverror = cverror + classification_error(labels,testlabels);
    end
    error = [error,cverror/5];
end

figure;
semilogx(C,error,'LineWidth',2);
title('C vs Cross-Validation error');
xlabel('Value of C');
ylabel('Cross-Validation Error');