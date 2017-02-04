n1 = 1000;
n2 = 1000;
n3 = 8124;

[w1,mistakes1,bounds1,totalwMistakes1] = winnow(1,n1);
[w2,mistakes2,bounds2,totalwMistakes2] = winnow(2,n2);
[w3,mistakes3,bounds3,totalwMistakes3] = winnow(3,n3);
figure;
semilogy(1:n1,mistakes1,'b-')
hold on
semilogy(1:n1,bounds1,'r--')
title('Performance of Winnow over iterations for data\_stream\_1.mat');
xlabel('Iteration Number');
ylabel('Fraction of misclassified examples');
legend('Fraction of mistakes','Mistake bound');
figure;
semilogy(1:n2,mistakes2,'b-')
hold on
semilogy(1:n2,bounds2,'r--')
title('Performance of Winnow over iterations for data\_stream\_2.mat');
xlabel('Iteration Number');
ylabel('Fraction of misclassified examples');
legend('Fraction of mistakes','Mistake bound');
figure;
semilogy(1:n3,mistakes3,'b-')
title('Performance of Winnow over iterations for data\_stream\_3.mat');
xlabel('Iteration Number');
ylabel('Fraction of misclassified examples');