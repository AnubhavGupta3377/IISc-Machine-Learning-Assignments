function model = SVM_learner(traindata, trainlabels, C, kerneltype, r)
    % INPUT : 
    % traindata   - m X n matrix, where m is the number of training points
    % trainlabels - m X 1 vector of training labels for the training data
    % C           - SVM regularization parameter (positive real number)
    % kerneltype  - one of strings 'linear', 'poly', 'rbf'
    %               corresponding to linear, polynomial, and RBF kernels
    %               respectively.
    % r           - integer parameter indicating the degree of the
    %               polynomial for polynomial kernel, or the width
    %               parameter for the RBF kernel; not used in the case of
    %               linear kerne and can be set to a default value.
    
    % OUTPUT
    % returns the structure 'model' which has the following fields, in
    % addition to the training data/parameters.(You can choose to add more
    % fields to this structure needed for your implementation)
    
    
    % 	alphas      	- m X 1 vector of support vector coefficients
    % 	b           	- SVM bias term
    % 	objective   	- optimal objective value of the SVM solver
    % 	support_vectors - the subset of training data, which are the support vectors
    
    % Default code below. Fill in the code for solving the
    % SVM dual optimization problem using quadprog function
    
    % Compute Kernel Matrix
    K = compute_kernel(traindata,traindata,kerneltype,r);
    
    % Compute matrix with entries y_i * y_j
    prodY = trainlabels*trainlabels';
    
    n = size(traindata,1);
    d = size(traindata,2);
    H = K.*prodY;
    f = -ones(n,1);
    lb = zeros(n,1);
    ub = C*ones(n,1);
    Aeq = trainlabels';
    beq = 0;
    support_vectors = [];
    b = 0;
    
    options = optimoptions('quadprog','Display','off');
    [alpha,dualValue,exitflag,output,lambda] = quadprog(H,f,[],[],Aeq,beq,lb,ub,[],options);
    
    for i = 1:n
        if alpha(i) > 0
            if alpha(i) < C
                support_vectors = [support_vectors;traindata(i,:)];
                b = b + sum((compute_kernel(traindata,traindata(i,:),kerneltype,r) .* (alpha.*trainlabels))) - trainlabels(i);
            end
        end
    end
    
    model.b = b / size(support_vectors,1);
    model.objective = -dualValue;
    model.alphas = alpha; 
    model.kerneltype = kerneltype;
    model.r = r;
    model.C = C;
    model.traindata = traindata;
    model.trainlabels = trainlabels;
    model.support_vectors = support_vectors;
end
