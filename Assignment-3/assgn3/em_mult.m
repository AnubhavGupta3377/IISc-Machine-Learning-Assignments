clear; close all; clc;
data = load('MoMult');
X = data.X;
N = size(X,1);
K = 3;
M = 3;
L = 3;
pi = ones(K,1) / K;
mu = rand(K,M,L);
denom = sum(mu,3);
for l = 1:L
    mu(:,:,l) = mu(:,:,l) ./ denom;
end

epsilon = 0.001;
old_likelihood = 0;
for n = 1:N
    val = 0;
    for k = 1:K
        prod = pi(k);
        for i = 1:M
            for j = 1:L
                prod = prod * (mu(k,i,j) ^ (X(n,i) == j));
            end
        end
        val = val + prod;
    end
    old_likelihood = old_likelihood + log(val);
end

% Let's perform EM for estimating mu and pi
new_likelihood = old_likelihood + epsilon + 1;
s = 'Initial Guess:';
disp(s);
pi
mu
log_likelihood = [old_likelihood];
while new_likelihood - old_likelihood > epsilon
    log_likelihood = [log_likelihood, new_likelihood];
    old_likelihood = new_likelihood;

    % E-Step
    q = zeros(N,K);
    for n = 1:N
        denom = 0;
        for k = 1:K
            prod = pi(k);
            for i = 1:M
                for j = 1:L
                    prod = prod * (mu(k,i,j) ^ (X(n,i) == j));
                end
            end
            denom = denom + prod;
        end
        for k = 1:K
            prod = pi(k);
            for i = 1:M
                for j = 1:L
                    prod = prod * (mu(k,i,j) ^ (X(n,i) == j));
                end
            end
            q(n,k) = prod / denom;
        end
    end

    % M-Step
    frac = sum(q);
    for k = 1:K
        for i = 1:M
            for j = 1:L
                mu(k,i,j) = (X(:,i)==j)'*q(:,k) / frac(k);
            end
        end
        pi(k) = frac(k) / N;
    end
    new_likelihood = 0;
    for n = 1:N
        val = 0;
        for k = 1:K
            prod = pi(k);
            for i = 1:M
                for j = 1:L
                    prod = prod * (mu(k,i,j) ^ (X(n,i) == j));
                end
            end
            val = val + prod;
        end
        new_likelihood = new_likelihood + log(val);
    end
end

s = 'Estimated Values:';
disp(s);
pi
mu

figure;
plot([1:size(log_likelihood,2)], log_likelihood);
title('Iterations of EM Algorithm on MoMult.mat dataset (epsilon = 0.001)');
xlabel('Iteration Number');
ylabel('Log Likelihood');


% Estimated Values:
% 
% pi =
% 
%     0.3848
%     0.2360
%     0.3792
% 
% 
% mu(:,:,1) =
% 
%     0.4150    0.0375    0.1870
%     0.1379    0.1751    0.6194
%     0.4978    0.9157    0.3319
% 
% 
% mu(:,:,2) =
% 
%     0.5849    0.3314    0.8130
%     0.0219    0.4494    0.3012
%     0.1313    0.0038    0.2376
% 
% 
% mu(:,:,3) =
% 
%     0.0002    0.6311    0.0000
%     0.8402    0.3756    0.0794
%     0.3709    0.0805    0.4305