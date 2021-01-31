clear all;
load('./Dataset/dataset_1.mat');
raw_data = Pd_rawData(:,1);
snr_db = -30:1:-10;
pd_svm = ones(1,length(snr_db));
pd_lr = ones(1,length(snr_db));
pd_knn = ones(1,length(snr_db));
pd_svm_de = ones(1,length(snr_db));
pd_lr_de = ones(1,length(snr_db));
beta = 1.5;
for i=1:length(snr_db)
    disp(i);
    %% DE
    data_set = preprocessing_de(raw_data,snr_db(i),beta);
    X = data_set(:,1);
    Y = data_set(:,2);
    %SVM
    mdlSVM = fitcsvm(X,Y,'Standardize',true);
    mdlSVM = fitPosterior(mdlSVM);
    [~,score_svm] = resubPredict(mdlSVM);
    [pf_svm,pdd_svm,Tsvm,AUCsvm] = perfcurve(logical(Y),score_svm(:,logical(mdlSVM.ClassNames)),'true');
    %Logistic
    model_lr = fitglm(X,Y,'Distribution','binomial','Link','logit');
    score_log = model_lr.Fitted.Probability;
    [pf_lr,pdd_lr,Tlog,AUClog] = perfcurve(data_set(:,2),score_log,'1');
    
    pd_svm_de(i) = pdd_svm(find(pf_svm<=0.1, 1, 'last' ));
    pd_lr_de(i) = pdd_lr(find(pf_lr<=0.1, 1, 'last' ));
    
    %% ED
    data_set = preprocessing(raw_data,snr_db(i));
    X = data_set(:,1);
    Y = data_set(:,2);

    %SVM
    mdlSVM = fitcsvm(X,Y,'Standardize',true);
    mdlSVM = fitPosterior(mdlSVM);
    [~,score_svm] = resubPredict(mdlSVM);
    [pf_svm,pdd_svm,Tsvm,AUCsvm] = perfcurve(logical(Y),score_svm(:,logical(mdlSVM.ClassNames)),'true');
    %Logistic
    model_lr = fitglm(X,Y,'Distribution','binomial','Link','logit');
    score_log = model_lr.Fitted.Probability;
    [pf_lr,pdd_lr,Tlog,AUClog] = perfcurve(logical(Y),score_log,'1');
    %KNN
    model_knn  = fitcknn(X,Y,'NumNeighbors',35);
    [~,score] = resubPredict(model_knn);
    [pf_knn,pdd_knn,Tsvm,AUCsvm] = perfcurve(logical(Y),score(:,logical(model_knn.ClassNames)),'true');
    
    pd_svm(i) = pdd_svm(find(pf_svm<=0.1, 1, 'last' ));
    pd_lr(i) = pdd_lr(find(pf_lr<=0.1, 1, 'last' ));
    pd_knn(i) = pdd_knn(find(pf_knn<=0.1, 1, 'last' ));
end

save('all.mat')