function data_set = preprocessing_gp(raw_data,snr_db,beta)
data = (raw_data - mean(raw_data))./sqrt(var(raw_data));
snr = 10^(snr_db/10);
N = length(data);
M = 25000;
data_set = zeros(2*M,2);
for i =1:M
    noise = ggnoise(1,N,1,beta);
    signal = sqrt(snr).*data' + ggnoise(1,N,1,beta);
    obs_H0 = find_gp(noise);
    obs_H1 = find_gp(signal);
    
    data_set(i,1) = obs_H0;
    data_set(i+M,1) = obs_H1;
    
    data_set(i,2) = 0;
    data_set(i+M,2) = 1;
end
col_data_set = data_set(:,1);
col_data_set = rescale(col_data_set);
data_set_temp = [col_data_set data_set(:,2)];
data_set = data_set_temp(randperm(size(data_set_temp, 1)), :);
