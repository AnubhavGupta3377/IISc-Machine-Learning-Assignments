path = sprintf('/home/anubhav/Desktop/Link to Machine Learning/Assignments/hw1-data-code/Problem-6/');
training = load(strcat(path,'Synthetic/train.txt'));
alltraindata = training(:,1:size(training,2)-1);
alltrainlabels = training(:,size(training,2));
testing = load(strcat(path,'Synthetic/test.txt'));
alltestdata = testing(:,1:size(testing,2)-1);
alltestlabels = testing(:,size(testing,2));

C = [1,10,100,1000,10000];
r = [1/32,1/4,1,4,32];

% Code for linear kernel
error = [];
for i = 1:5
    c = C(i);
    cverror = 0;
    for fold = 1:5
        training = load(strcat(path,sprintf('Synthetic/CrossValidation/Fold%d/cv-train.txt',fold)));
        traindata = training(:,1:size(training,2)-1);
        trainlabels = training(:,size(training,2));
        testing = load(strcat(path,sprintf('Synthetic/CrossValidation/Fold%d/cv-test.txt',fold)));
        testdata = testing(:,1:size(testing,2)-1);
        testlabels = testing(:,size(testing,2));
        model = SVM_learner(traindata,trainlabels,c,'linear',1);
        labels = SVM_classifier(testdata,model);
        cverror = cverror + classification_error(labels,testlabels);
    end
    error = [error,cverror/5];
end
error_linear = error;
[val,C_opt] = min(error);
model = SVM_learner(alltraindata,alltrainlabels,C(C_opt),'linear',1);
trlabels = SVM_classifier(alltraindata,model);
trerror = classification_error(alltrainlabels,trlabels);
telabels = SVM_classifier(alltestdata,model);
teerror = classification_error(alltestlabels,telabels);
msg = sprintf('Error on training data for linear kernel: %e', trerror);
disp(msg);
msg = sprintf('Error on test data for linear kernel: %e', teerror);
disp(msg);

figure;
decision_boundary_SVM(alltestdata,alltestlabels,model,100);
title('Classification of test data by linear kernel SVM');



% Code for quadratic kernal
error = [];
for i = 1:5
    c = C(i);
    cverror = 0;
    for fold = 1:5
        training = load(strcat(path,sprintf('Synthetic/CrossValidation/Fold%d/cv-train.txt',fold)));
        traindata = training(:,1:size(training,2)-1);
        trainlabels = training(:,size(training,2));
        testing = load(strcat(path,sprintf('Synthetic/CrossValidation/Fold%d/cv-test.txt',fold)));
        testdata = testing(:,1:size(testing,2)-1);
        testlabels = testing(:,size(testing,2));
        model = SVM_learner(traindata,trainlabels,c,'poly',2);
        labels = SVM_classifier(testdata,model);
        cverror = cverror + classification_error(labels,testlabels);
    end
    error = [error,cverror/5];
end
error_poly2 = error;
[val,C_opt] = min(error);
model = SVM_learner(alltraindata,alltrainlabels,C(C_opt),'poly',2);
trlabels = SVM_classifier(alltraindata,model);
trerror = classification_error(alltrainlabels,trlabels);
telabels = SVM_classifier(alltestdata,model);
teerror = classification_error(alltestlabels,telabels);
msg = sprintf('Error on training data for quadratic kernel: %e', trerror);
disp(msg);
msg = sprintf('Error on test data for quadratic kernel: %e', teerror);
disp(msg);

figure;
decision_boundary_SVM(alltestdata,alltestlabels,model,100);
title('Classification of test data by quadratic kernel SVM');



% Code for cubic kernal
error = [];
for i = 1:5
    c = C(i);
    cverror = 0;
    for fold = 1:5
        training = load(strcat(path,sprintf('Synthetic/CrossValidation/Fold%d/cv-train.txt',fold)));
        traindata = training(:,1:size(training,2)-1);
        trainlabels = training(:,size(training,2));
        testing = load(strcat(path,sprintf('Synthetic/CrossValidation/Fold%d/cv-test.txt',fold)));
        testdata = testing(:,1:size(testing,2)-1);
        testlabels = testing(:,size(testing,2));
        model = SVM_learner(traindata,trainlabels,c,'poly',3);
        labels = SVM_classifier(testdata,model);
        cverror = cverror + classification_error(labels,testlabels);
    end
    error = [error,cverror/5];
end
error_poly3 = error;
[val,C_opt] = min(error);
model = SVM_learner(alltraindata,alltrainlabels,C(C_opt),'poly',3);
trlabels = SVM_classifier(alltraindata,model);
trerror = classification_error(alltrainlabels,trlabels);
telabels = SVM_classifier(alltestdata,model);
teerror = classification_error(alltestlabels,telabels);
msg = sprintf('Error on training data for cubic kernel: %e', trerror);
disp(msg);
msg = sprintf('Error on test data for cubic kernel: %e', teerror);
disp(msg);

figure;
decision_boundary_SVM(alltestdata,alltestlabels,model,100);
title('Classification of test data by cubic kernel SVM');



rbferrors = [];
% Code for rbf kernel
for R = 1:5
    error = [];
    for i = 1:5
        c = C(i);
        cverror = 0;
        for fold = 1:5
            training = load(strcat(path,sprintf('Synthetic/CrossValidation/Fold%d/cv-train.txt',fold)));
            traindata = training(:,1:size(training,2)-1);
            trainlabels = training(:,size(training,2));
            testing = load(strcat(path,sprintf('Synthetic/CrossValidation/Fold%d/cv-test.txt',fold)));
            testdata = testing(:,1:size(testing,2)-1);
            testlabels = testing(:,size(testing,2));
            model = SVM_learner(traindata,trainlabels,c,'rbf',r(R));
            labels = SVM_classifier(testdata,model);
            cverror = cverror + classification_error(labels,testlabels);
        end
        error = [error,cverror/5];
    end
    rbferrors = [rbferrors;error];
    [val,C_opt] = min(error);
    model = SVM_learner(alltraindata,alltrainlabels,C(C_opt),'rbf',r(R));
    trlabels = SVM_classifier(alltraindata,model);
    trerror = classification_error(alltrainlabels,trlabels);
    telabels = SVM_classifier(alltestdata,model);
    teerror = classification_error(alltestlabels,telabels);
    msg = sprintf('Error on training data for rbf kernel with r = %e: %e', r(R), trerror);
    disp(msg);
    msg = sprintf('Error on test data for rbf kernel with r = %e: %e', r(R), teerror);
    disp(msg);

    figure;
    decision_boundary_SVM(alltestdata,alltestlabels,model,100);
    title(sprintf('Classification of test data by rbf kernel SVM with r = %e', r(R)));
end


figure;
semilogx(C,error_linear,'b-','LineWidth',2);
hold on
semilogx(C,error_poly2,'r-','LineWidth',2);
hold on
semilogx(C,error_poly3,'g--','LineWidth',2);
hold on
semilogx(C,rbferrors(1,:),'g-', 'LineWidth',2);
hold on
semilogx(C,rbferrors(2,:),'y-', 'LineWidth',2);
hold on
semilogx(C,rbferrors(3,:),'k--', 'LineWidth',2);
hold on
semilogx(C,rbferrors(4,:),'r--', 'LineWidth',2);

title('SVM - C vs Cross-Validation error for differnt types of kernels');
xlabel('Value of C');
ylabel('Cross-Validation Error');
legend('Linear Kernel', 'Quadratic Kernal', 'Cubic Kernal',...
    'rbf kernel r = 1/32','rbf kernel r = 1/4',...
    'rbf kernel r = 1','rbf kernel r = 4');
grid on

figure
semilogx(C,rbferrors(5,:),'b-', 'LineWidth',3);
title('SVM - C vs Cross-Validation error for rbf kernel with r = 32');
xlabel('Value of C');
ylabel('Cross-Validation Error');
grid on