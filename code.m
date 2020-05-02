clc
close all
clear all
L = 8192;
fs = 4000;
ts = 1/fs;
fm = 16;
f0 = 512;
t=0:ts:(L-1)/fs;
l = 32;
m = 256;
ys = 2.*cos(2*pi*fm*t).*cos(2*pi*f0*t);
snr_dB = -22; % SNR in decibels
snr = 10.^(snr_dB./10); % Linear Value of SNR
pf = 0.01:0.01:1; % Pf = Probability of False Alarm
%% Simulation to plot Probability of Detection (Pd) vs. Probability of False Alarm (Pf) 
for k = 1:length(pf)
    k
    i = 0;
    for kk=1:10000 % Number of Monte Carlo Simulations
     n = randn(1,L); %AWGN noise with mean 0 and variance 1
     n = normrnd(1,sqrt(1/snr),[1,L]);
     s = sqrt(snr).*randn(1,L); % Real valued Gaussina Primary User Signal 
     Y = ys + n; % Received signal at SU
     Y = reshape(Y,m,l);
     Ys = fft(Y);
     energy = mean(abs(Ys).^2,1);
     Y = fft(Y);
     energy = abs(Y).^2; % Energy of received signal over N samples
     energy_fin =(2*snr).*sum(energy); % Test Statistic for the energy detection
     thresh(m) = (qfuncinv(Pf(m))./sqrt(L))+ 1; % Theoretical value of Threshold, refer, Sensing Throughput Tradeoff in Cognitive Radio, Y. C. Liang
     Ted(k) = 2*gammaincinv(1-pf(k),l);
     if(energy_fin >= Ted(k))  % Check whether the received energy is greater than threshold, if so, increment Pd (Probability of detection) counter by 1
         i = i+1;
     end
    end
Pd(k) = i/kk; 
end
plot(pf, Pd)
hold on
%% Theroretical ecpression of Probability of Detection; refer above reference.
ted = 2*gammaincinv(1-pf,l);
Pd_the = 1-ncx2cdf(ted,2*l,m*l*snr/2);
plot(pf, Pd_the, 'r')
hold on
