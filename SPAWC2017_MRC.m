% Author: Prabhu Chandhar, Chandhar Research Labs, Chennai, India.


clc;
clear all;
setpath;
f = 2.5e9; % Hz
c = 3e8; % m/s
lambda = c/f; % m

del = .5*lambda;

K = 20;

M = [10:10:100 200:100:1000];
lp_M=1;
for M = [10:10:100 200:100:1000];
y = Calc_SPAWC2017(M,K,del,lambda);
q1 = 1/100;
q10 = 10/100;
eta1(lp_M) = outageCalculation(sum(y)/M^2,1-q1,'TPT');
eta10(lp_M) = outageCalculation(sum(y)/M^2,1-q10,'TPT');
C_out_1(lp_M) = log2(1+(1./(eta1(lp_M,lp_d)+(1/M))));
C_out_10(lp_M) = log2(1+(1./(eta10(lp_M,lp_d)+(1/M))));
lp_M=lp_M+1;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Figure 1 %%%%%%%%%%%%%%%%%%%%%%%%%

M=10:1000;
q=1/100;
figure(1);semilogy(M,log2(1+(1./(((K-1)./M./q)+(1./M/rho)))));hold on;
figure(1);semilogy(M,log2(1+(M./(((K-1))+sqrt((K-1).*(M-1).*(2*M-1))./3./M/q)+(1/rho))));hold on;
figure(1);semilogy(M,C_out_1);
xlabel('Numberof BS antennas [M]');ylabel('1% outage capacity (bits/sec/Hz)');
legend('Markov bound (Equation (35))','Chebyshev bound (Equation (35))','Simulation');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Figure 2 %%%%%%%%%%%%%%%%%%%%%%%%%

rho=1;K=20;M=10:1000;
q=10/100;
figure(2);semilogy(M,log2(1+(1./(((K-1)./M./q)+(1./M/rho)))));hold on;
figure(2);semilogy(M,log2(1+(M./(((K-1))+sqrt((K-1).*(M-1).*(2*M-1))./3./M/q)+(1/rho))));hold on;
figure(2);semilogy(M,C_out_10);
xlabel('Numberof BS antennas [M]');ylabel('10% outage capacity (bits/sec/Hz)');
legend('Markov bound (Equation (35))','Chebyshev bound (Equation (35))','Simulation');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Figure 3 %%%%%%%%%%%%%%%%%%%%%%%%%

rho = 1; K = 20; M = [20:20:1e2 2e2:1e2:2000];% 2e2:1e2:1e3 2e3:1e3:1e4 2e4:1e4:1e5 2e5:1e5:1e6 2e6:1e6:1e7];
for q = [.1 1 10]/100
R = log2(1+(M*rho./(((rho*(K-1)/q))+1)));
figure(3);subplot(2,1,1);plot(M,R);hold on;
end
xlabel('M');ylabel('R_{q}^{Mkv,lb} (bits/sec/Hz)');axis tight;


rho = 1; K = 20; M = [1e5:1e5:1e7];% 2e2:1e2:1e3 2e3:1e3:1e4 2e4:1e4:1e5 2e5:1e5:1e6 2e6:1e6:1e7];
for q = [.1 1 10]/100
R = log2(1+(M*rho./(((rho*(K-1)/q))+1)));
figure(3);subplot(2,1,2);semilogx(M,R);hold on;
end
xlabel('M');ylabel('R_{q}^{Mkv,lb} (bits/sec/Hz)');axis tight;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Figure 4 %%%%%%%%%%%%%%%%%%%%%%%%%

for M = [20 50 100 200 500 1000];
y = Calc_SPAWC2017(M,K,del,lambda);
figure(401);cdfplot(sum(y)/M^2);hold on;
end
xlabel('U');ylabel('CDF');axis([0 4 0 1]);
