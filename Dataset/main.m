clear all;
load('./Dataset/dataset_1.mat');
raw_data = Pd_rawData(:,1);
snr_db = -25:-10;
pd_svm = ones(1,length(snr_db));
pd_lr = ones(1,length(snr_db));
pd_knn = ones(1,length(snr_db));
pd_svm_de = ones(1,length(snr_db));
pd_lr_de = ones(1,length(snr_db));
pd_knn_de = ones(1,length(snr_db));
beta = 1;
for i=1:length(snr_db)
    fprintf('Sl no. SNR: %d\n',i);
    %% DE
    data_set = preprocessing_de(raw_data,snr_db(i),beta);
    X = data_set(:,1);
    Y = data_set(:,2);
    fprintf('trianing \n');
    model_knn  = fitcknn(X,Y,'NumNeighbors',20);
    [~,score] = resubPredict(model_knn);
    [pf_knn_de,pdd_knn_de,Tsvm,AUCsvm] = perfcurve(logical(Y),score(:,logical(model_knn.ClassNames)),'true');
    %SVM
%     mdlSVM = fitcsvm(X,Y,'Standardize',true);
%     mdlSVM = fitPosterior(mdlSVM);
%     [~,score_svm] = resubPredict(mdlSVM);
%     [pf_svm_de,pdd_svm_de,Tsvm,AUCsvm] = perfcurve(logical(Y),score_svm(:,logical(mdlSVM.ClassNames)),'true');
    %Logistic
%     model_lr = fitglm(X,Y,'Distribution','binomial','Link','logit');
%     score_log = model_lr.Fitted.Probability;
%     [pf_lr,pdd_lr,Tlog,AUClog] = perfcurve(data_set(:,2),score_log,'1');
    
%     pd_svm_de(i) = pdd_svm(find(pf_svm<=0.1, 1, 'last' ));
%     pd_lr_de(i) = pdd_lr(find(pf_lr<=0.1, 1, 'last' ));
      pd_knn_de(i) = pdd_knn_de(find(pf_knn_de<=0.1, 1, 'last' ));
    %% ED
    %SVM
    data_set = preprocessing_gp(raw_data,snr_db(i),beta);
    fprintf('ED\n');
    X = data_set(:,1);
    Y = data_set(:,2);
%     mdlSVM = fitcsvm(X,Y,'Standardize',true);
%     mdlSVM = fitPosterior(mdlSVM);
%     [~,score_svm] = resubPredict(mdlSVM);
%     [pf_svm,pdd_svm,Tsvm,AUCsvm] = perfcurve(logical(Y),score_svm(:,logical(mdlSVM.ClassNames)),'true');
    %Logistic
%     model_lr = fitglm(X,Y,'Distribution','binomial','Link','logit');
%     score_log = model_lr.Fitted.Probability;
%     [pf_lr,pdd_lr,Tlog,AUClog] = perfcurve(logical(Y),score_log,'1');
    %KNN
    model_knn  = fitcknn(X,Y,'NumNeighbors',20);
    [~,score] = resubPredict(model_knn);
    [pf_knn,pdd_knn,Tsvm,AUCsvm] = perfcurve(logical(Y),score(:,logical(model_knn.ClassNames)),'true');
    
%     pd_svm(i) = pdd_svm(find(pf_svm<=0.1, 1, 'last' ));
%     pd_lr(i) = pdd_lr(find(pf_lr<=0.1, 1, 'last' ));
    pd_knn(i) = pdd_knn(find(pf_knn<=0.1, 1, 'last' ));
end

save('gp_knn_beta_1.mat')