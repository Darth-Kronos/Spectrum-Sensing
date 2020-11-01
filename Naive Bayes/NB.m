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

T = 2500;
obs_H0 = zeros(1,T);
obs_H1 = zeros(1,T);

%% Training samples

for i=1:T
    noise = sqrt(1/snr)*randn(1,L);
    Signal = sqrt(1/snr)*randn(1,L) + ys;
    obs_H0(i) = find_energy(noise,f0,fs,samples,m,l,snr);
    obs_H1(i) = find_energy(Signal,f0,fs,samples,m,l,snr);

end
train_X = cat(2,obs_H0,obs_H1);
train_Y = cat(2, zeros(1,2500),ones(1,2500));
Mdl = fitcnb(train_X',train_Y');

%% Monte carlo

M = 100;
obs_H0 = zeros(1,M);
obs_H1 = zeros(1,M);
pf = zeros(1,M);
pd = zeros(1,M);
for i=1:M
    for j=1:M
        noise = sqrt(1/snr)*randn(1,L);
        Signal = sqrt(1/snr)*randn(1,L) + ys;
        obs_H0 = find_energy(noise,f0,fs,samples,m,l,snr);
        obs_H1 = find_energy(Signal,f0,fs,samples,m,l,snr);
        if(Mdl.predict(obs_H0) == 1)
            pf(i) = pf(i) +1;
        end
        if(Mdl.predict(obs_H1) == 1)
            pd(i) = pd(i) +1;
        end
    end
end
pf = pf./2500;
pd = pd./2500;
plot(pd,pf)