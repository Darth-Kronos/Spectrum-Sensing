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
pf = 0.01:0.01:1; % Pf = Probability of False Alarm
%% Simulation to plot Probability of Detection (Pd) vs. Probability of False Alarm (Pf) 
for k = 1:length(pf)
    k
    i = 0;
    for kk=1:10000 % Number of Monte Carlo Simulations
     n = normrnd(1,sqrt(1/snr),[1,L]); % AWGN noise with variance 1/ snr
     Y = ys + n; % Received signal
     Y = reshape(Y,m,l); % Dividing the samples into L segments of M length
     Ys = fft(Y); % Taking a coloumwise fft of length M
     r = abs(Ys).^2; % 
     energy = mean(r,1);
     Ted =(2*snr).*sum(energy); % Test Statistic for the energy detection
     %thresh(m) = (qfuncinv(Pf(m))./sqrt(L))+ 1; % Theoretical value of Threshold
     ted(k) = 2*gammaincinv(1-pf(k),l);
     if(ted >= Ted(k))  % Check whether the received energy is greater than threshold, if so, increment Pd counter by 1
         i = i+1;
     end
    end
Pd(k) = i/kk; 
end
plot(pf, Pd)
hold on
%% Theroretical ecpression of Probability of Detection; refer above reference.
Ted = 2*gammaincinv(1-pf,l);
Pd_the = 1- ncx2cdf(Ted,2*l,m*l*snr/2);
plot(pf, Pd_the, 'r')
hold on
