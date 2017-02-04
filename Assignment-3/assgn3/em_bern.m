clear; close all; clc;
data = load('MoBern');
X = data.X;
N = size(X,1);
K = 5;
M = 5;
pi = ones(K,1) / K;
mu = rand(K,M);
old_likelihood = 0;
epsilon = 0.001;
for n = 1:N
    old_likelihood = old_likelihood + log(prod((mu .^ repmat(X(n,:), size(mu,1), 1)) .* ((1-mu) .^ repmat((1-X(n,:)), size(mu,1), 1)), 2)' * pi);
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
        denom = prod((mu .^ repmat(X(n,:), size(mu,1), 1)) .* ((1-mu) .^ repmat((1-X(n,:)), size(mu,1), 1)), 2)' * pi;
        q(n,:) = (prod((mu .^ repmat(X(n,:), size(mu,1), 1)) .* ((1-mu) .^ repmat((1-X(n,:)), size(mu,1), 1)), 2) .* pi) / denom;
    end

    % M-Step
    frac = sum(q);
    for k = 1:K
        mu(k,:) = (q(:,k)' * X) / frac(k);
        pi(k) = frac(k) / N;
    end
    new_likelihood = 0;
    for n = 1:N
        new_likelihood = new_likelihood + log(prod((mu .^ repmat(X(n,:), size(mu,1), 1)) .* ((1-mu) .^ repmat((1-X(n,:)), size(mu,1), 1)), 2)' * pi);
    end
end

s = 'Estimated Values:'
pi
mu

figure;
plot([1:size(log_likelihood,2)], log_likelihood);
title('Iterations of EM Algorithm on MoBern.mat dataset (epsilon = 0.001)');
xlabel('Iteration Number');
ylabel('Log Likelihood');


% Estimated Values:
%{

pi =

    0.2994
    0.1956
    0.1693
    0.0688
    0.2668


mu =

    0.1740    0.8319    0.1410    0.1119    0.1103
    0.0479    0.0723    0.0815    0.8453    0.8171
    0.9597    0.0238    0.2692    0.1622    0.1595
    0.4303    0.7738    0.8961    0.0599    0.0744
    0.0617    0.0131    0.8978    0.0957    0.1199
%}