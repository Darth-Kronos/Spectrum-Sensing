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

M = 500;
y = zeros(M,3);
n = zeros(M,3);
op = zeros(M,1);
data_set = zeros(2*M,4);


for i=1:M
    noise = sqrt(1/snr)*randn(1,L);
    Signal = sqrt(1/snr)*randn(1,L) + ys;
    data_set(i,1) = find_energy(Signal,f0,fs,samples,m,l,snr);
    data_set(i+M,1) = find_energy(noise,f0,fs,samples,m,l,snr);
    [s1,s2] = find_cov(Signal);
    [n1,n2] = find_cov(noise);
    data_set(i,2) = s1;
    data_set(i,3) = s2;
    data_set(i+M,2) = n1;
    data_set(i+M,3) = n2;
    data_set(i,4) = 1;
    data_set(i+M,4) = 0;
    disp(i);
end
data_set = data_set(randperm(size(data_set, 1)), :);
for i=1:4
    data_set(:,i) = rescale(data_set(:,i));
end
save('data_set_10.mat','data_set');

