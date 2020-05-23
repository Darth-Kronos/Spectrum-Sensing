clc
close all
clear all
samples = 0:8191;
fs = 4000;
L = 8192;
ts = 1/fs;
fm = 16;
f0 = 512;
l = 32;
m = 256;
ys = 2.*cos(2*pi*fm/fs.*samples) .*cos(2*pi*f0/fs.*samples);
snr_dB = -22; %SNR in decibels
snr = 10.^(snr_dB./10); % Linear Value of SNR
M = 100000;
obs_H0 = zeros(1,M);
obs_H1 = zeros(1,M);
%% simulation
for i=1:M
    noise = sqrt(1/snr)*randn(1,L)+i*sqrt(1/snr)*randn(1,L) ; 
    Signal = sqrt(1/snr)*randn(1,L)+i*sqrt(1/snr)*randn(1,L) + ys;
    obs_H0(i) = find_energy(noise,m,l,snr);
    obs_H1(i) = find_energy(Signal,m,l,snr);
end
tmax = max([obs_H0,obs_H1]);
tmin = min([obs_H0,obs_H1]);
threshold = linspace(tmin,tmax,1000);
pf = zeros(1,length(threshold));
pd = zeros(1,length(threshold));
%% probability of false alarm and probability of detection
for i=1:length(threshold)
    pf(i) = sum(obs_H0>=threshold(i))/M;
    pd(i) = sum(obs_H1>=threshold(i))/M;
end
plot(pf,pd,'b--o','MarkerIndices',1:5:length(pd))
hold on
%% Theroretical expression of Probability of Detection
%%% ED
pf_the = 0:0.01:1;
Ted = 2*gammaincinv(1-pf_the,l);
pd_the = 1- ncx2cdf(Ted,2*l,m*l*snr/2);
%%% MFD 
% E = sum(ys.*ys);
% pf_the = 0:0.01:1;
% Tmfd = qfuncinv(pf_the).*sqrt(E./snr);
% pd_the = qfunc((Tmfd - E)./sqrt(E./snr));
plot(pf_the, pd_the)
legend('ED','ED Theoretical')