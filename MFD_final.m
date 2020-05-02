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
ys = 2.*cos(2*pi*fm.*samples) .*cos(2*pi*f0.*samples);
snr_dB = -25:10:45; % SNR in decibels
snr = 10.^(snr_dB./10); % Linear Value of SNR
pf = 0.01:0.01:1; % Pf = Probability of False Alarm
%% Simulation to plot Probability of Detection (Pd) vs. Probability of False Alarm (Pf) 
for a = 1:length(snr)
for k = 1:length(pf)
    Pd(k) = qfunc(qfuncinv(pf(k))-sqrt(snr(a)))
    
end
plot(pf, Pd)
hold on
end
legend("-25db","-15db","5db","15db","25","35","45")


