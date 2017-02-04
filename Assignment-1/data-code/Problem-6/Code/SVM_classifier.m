function labels = SVM_classifier(testdata, model)
    % INPUT
    % testdata - m X n matrix of the test data samples
    % model    - SVM model structure returned by SVM_learner
    
    % OUTPUT
    % labels - m x 1 vector of predicted labels
    
    % Write code here
    
    traindata = model.traindata;
    trainlabels = model.trainlabels;
    alphas = model.alphas;
    kerneltype = model.kerneltype;
    r = model.r;
    alphaY = [];
    for i = 1:size(testdata,1)
        alphaY = [alphaY,(alphas.*trainlabels)];
    end
    labels = sign(sum(compute_kernel(traindata,testdata,kerneltype,r) .* alphaY)' - ones(size(testdata,1),1)*model.b);
end
