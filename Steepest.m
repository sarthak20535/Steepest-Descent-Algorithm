%Example of SDM filter
clc;
close all;
clear all;
%Generate a signal
n=0.001:0.001:1
d=2*sin(2*pi*50*n);
figure;
plot(d);N=numel(d);
%Noisy version of the signal
x=d(1:N)+0.9*randn(1,N);
R=[];k=1;
%SDM initialization parameters
r=xcorr(x);M=25;wi=zeros(M,1);wn=zeros(M,1);rr=[];
for i=1:1:M
 rr(i)=r(N-i+1);
end
R=toeplitz(rr);ei=max(eig(R));u=1/ei;
p=xcorr(d,x);
for i=1:1:M
 P(i)=p(N-i+1);
end
% Iterative while loop
k=2
while 1
 wn=wi+u*(P'-R*wi)
 % Stopping criterion
 if norm(P'-R*wi) < 1e-5
 % Number of iterations performed by algorithm
 wopt=wn
 fprintf('Number of iterations: %d\n',k-1);
 break
 else
 k=k+1
 wi=wn
 end
end
y=zeros(N,1);
for i=M:N
 j=x(i:-1:i-M+1);
 y(i)=(wn)'*(j)';
end
e=y'-d;
subplot(4,1,1),plot(d);title('desired signal');
xlabel('Time');
ylabel('Amplitude');
subplot(4,1,2),plot(x);ylim([-5 5]);title('signal corrupted with noise');
xlabel('Time');
ylabel('Amplitude');
subplot(4,1,3),plot(y);title('estimated signal');
Page 10 of 11
xlabel('Time');
ylabel('Amplitude');
subplot(4,1,4),plot(e);ylim([-5 5]);title('error signal');
xlabel('Time');
ylabel('Amplitude');
