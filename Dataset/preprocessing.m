function data_set = preprocessing(raw_data,snr_db)
data = (raw_data - mean(raw_data))./sqrt(var(raw_data));
snr = 10^(snr_db/10);
N = length(data);
M = 25000;
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
end

data_set = data_set(randperm(size(data_set, 1)), :);
