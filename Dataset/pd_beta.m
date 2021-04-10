clear all;
load('./Dataset/dataset_1.mat');

raw_data = Pd_rawData(:,1);
snr_db = [-22,-15,];

pd_svm = ones(1,length(snr_db));
pd_lr = ones(1,length(snr_db));
pd_knn = ones(1,length(snr_db));
pd_svm_de = ones(1,length(snr_db));
pd_lr_de = ones(1,length(snr_db));
pd_knn_de = ones(1,length(snr_db));

beta = 0.1:0.1:2;
% beta X SNR
result_matrix = zeros(length(beta),length(snr_db));

for i=1:length(snr_db)
    fprintf('Sl no. SNR: %d\n',i);
    for j=1:length(beta)
        fprintf('Sl no. beta: %d\n',j);
        data_set = preprocessing_de(raw_data,snr_db(i),beta(j));
        X = data_set(:,1);
        Y = data_set(:,2);
        fprintf('training \n');
        model_randomforests = fitcensemble(X,Y);
        [~,score] = resubPredict(model_randomforests);
        [pf_randomforests,pdd_randomforests_de,Tsvm,AUCsvm] = perfcurve(logical(Y),score(:,logical(model_randomforests.ClassNames)),'true');
        result_matrix(j,i) = pdd_randomforests_de((find(pf_randomforests<=0.1, 1, 'last' ))); 
    end
    fprintf('\n');
end

save('pd_beta_result_2.mat')