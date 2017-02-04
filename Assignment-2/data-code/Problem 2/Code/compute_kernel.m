function K = compute_kernel(x1, x2)
%This function computes the rbf-kernel function given two vectors (or matrices)
%x1         - 1*n vector(or m_1 x n matrix) corresponding to one instances (or 'm_1' instances)
%x2         - 1*n vector(or m_2 x n matrix) corresponding to the second instance (or 'm_2' instances)

%Output
% kernel value when the inputs are two vectos (and m_1 x m_2  kernel matrix when the inputs are matrices of instances)
    r = 1;
    linearK = x1 * x2';    
    K1 = repmat(diag(x1 * x1'), 1, size(x2, 1));
    K2 = repmat(diag(x2 * x2'), 1, size(x1, 1));
    D = K1 + K2' - 2*linearK;
    K = exp(-D/(2*r^2));
end