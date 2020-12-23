clear all;
load('./Dataset/dataset_1.mat');
raw_data = Pd_rawData(:,1);
snr_db = -35:1:-15;
pd = ones(1,length(snr_db));
for i=1:length(snr_db)
    disp(i);
    data_set = preprocessing(raw_data,snr_db(i));
    X = data_set(:,1);
    Y = data_set(:,2);
%     model = fitcsvm(X,Y,'NumNeighbors',25);
    model = fitcsvm(X,Y,'Standardize',true);
    model = fitPosterior(model);
    [~,score] = resubPredict(model);
    [pf,pdd,Tsvm,AUCsvm] = perfcurve(logical(Y),score(:,logical(model.ClassNames)),'true');
    pd(i) = pdd(find(pf<=0.1, 1, 'last' ));
end

plot(snr_db,pd)