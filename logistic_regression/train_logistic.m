clc;
close all;
clear all;
ii=1;
snrr = [-30:1:-2];
pdd=ones(1,size(snrr,2));
for snr = snrr
load('/home/akshay/Desktop/Spectrum-Sensing/Dataset/dataset_1.mat');
avg_data = Pd_rawData(:,1);
data = (avg_data - mean(avg_data))./sqrt(var(avg_data));
snr = 10^(snr/10); % snr = -18 dB
N = length(data);
M = 5000;
data_set = zeros(2*M,2);
for i =1:M
        noise = randn(1,N)';
        signal = sqrt(snr).*data + randn(1,N)';
        obs_H0 = find_energy(noise,snr);
        obs_H1 = find_energy(signal,snr);
    
        data_set(i,1) = obs_H0;
        data_set(i+M,1) = obs_H1;
    
        data_set(i,2) = 1;
        data_set(i+M,2) = 0;
    
        %disp(i);
end

data_set = data_set(randperm(size(data_set, 1)), :);
data_set(:,1) = rescale(data_set(:,1));

mdl = fitglm(data_set(:,1),data_set(:,2),'Distribution','binomial','Link','logit');
score_log = mdl.Fitted.Probability; % Probability estimates
[pf,pd,Tlog,AUClog] = perfcurve(data_set(:,2),score_log,'1');
plot(pf,pd);


%o=1;
%while(pf(o) > 0.1)
%    o=o+1;
%end
[m,o] = min(abs(pf-0.1));
disp(pf(o));disp(pd(o));
%o=o-1;
if m < 0.05
    pdd(ii) = pd(o);ii=ii+1;
else
    pdd(ii) = 1;ii=ii+1;
end
















end
plot(snrr,pdd);