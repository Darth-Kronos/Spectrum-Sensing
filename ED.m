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
pf = 0:0.01:1; % Pf = Probability of False Alarm
%% Simulation to plot Probability of Detection (Pd) vs. Probability of False Alarm (Pf) 
% for k = 1:length(pf)
%     k
%     i = 0;
%     for kk=1:10000 % Number of Monte Carlo Simulations
%      noise = normrnd(0,sqrt(1/snr),[1,L]) + ; % AWGN noise with variance 1/ snr
%      Signal = ys + normrnd(0,sqrt(1/snr),[1,L]); % Received signal
%      noise_energy = find_energy(noise,m,l,snr);
%      Signal_energy = find_energy(Signal,m,l,snr);
%      
%      ted(k) = 2*gammaincinv(1-pf(k),l);
%      if(Ted >= ted(k))  % Check whether the received energy is greater than threshold, if so, increment Pd counter by 1
%          i = i+1;
%      end
%     end
% Pd(k) = i/kk; 
% end
thershold = linspace(-sqrt(snr)
plot(pf, Pd)
hold on
%% Theroretical ecpression of Probability of Detection; refer above reference.
Ted = 2*gammaincinv(1-pf,l);
Pd_the = 1- ncx2cdf(Ted,2*l,m*l*snr/2);
plot(pf, Pd_the, 'r')
hold on