clear all;
load('dataset_3.mat');
raw_data = Dataset3(:,1);
raw_data = raw_data(1:5000);
snr_db = -30:-10;
pd_svm = ones(1,length(snr_db));
pd_lr = ones(1,length(snr_db));
pd_randomforests = ones(1,length(snr_db));
pd_svm_de = ones(1,length(snr_db));
pd_lr_de = ones(1,length(snr_db));
pd_randomforests_de = ones(1,length(snr_db));
beta = 2;
array_pfvalues=[];
for i=1:length(snr_db)
    fprintf('Sl no. SNR: %d\n',i);
    %% DE
    data_set = preprocessing_de(raw_data,snr_db(i),beta);
    X = data_set(:,1);
    Y = data_set(:,2);
    fprintf('training \n');
%     model_knn  = fitcknn(X,Y,'NumNeighbors',35);
    model_randomforests = fitcensemble(X,Y);
    [~,score] = resubPredict(model_randomforests);
    [pf_randomforests,pdd_randomforests_de,Tsvm,AUCsvm] = perfcurve(logical(Y),score(:,logical(model_randomforests.ClassNames)),'true');
    %SVM
%     mdlSVM = fitcsvm(X,Y,'Standardize',true);
%     mdlSVM = fitPosterior(mdlSVM);
%     [~,score_svm] = resubPredict(mdlSVM);
%     [pf_svm,pdd_svm,Tsvm,AUCsvm] = perfcurve(logical(Y),score_svm(:,logical(mdlSVM.ClassNames)),'true');
    %Logistic
%      model_lr = fitglm(X,Y,'Distribution','binomial','Link','logit');
%      score_log = model_lr.Fitted.Probability;
%      [pf_lr,pdd_lr,Tlog,AUClog] = perfcurve(data_set(:,2),score_log,'1');
    
%     pd_svm_de(i) = pdd_svm(find(pf_svm<=0.1, 1, 'last' ));
%     pd_lr_de(i) = pdd_lr(find(pf_lr<=0.1, 1, 'last' ));
    
% <<<<<<< Updated upstream

%     pd_svm_de(i) = pdd_svm(find(pf_svm<=0.1, 1, 'last' ));
%     pd_lr_de(i) = pdd_lr(find(pf_lr<=0.1, 1, 'last' ));
      pd_randomforests_de(i) = pdd_randomforests_de(find(pf_randomforests<=0.1, 1, 'last' ));
% >>>>>>> Stashed changes
    %% ED
    %SVM
    data_set = preprocessing(raw_data,snr_db(i),beta);
    fprintf('ED\n');
    X = data_set(:,1);
    Y = data_set(:,2);
%     mdlSVM = fitcsvm(X,Y,'Standardize',true);
%     mdlSVM = fitPosterior(mdlSVM);
%     [~,score_svm] = resubPredict(mdlSVM);
%     [pf_svm,pdd_svm,Tsvm,AUCsvm] = perfcurve(logical(Y),score_svm(:,logical(mdlSVM.ClassNames)),'true');
    %Logistic
%      model_lr = fitglm(X,Y,'Distribution','binomial','Link','logit');
%      score_log = model_lr.Fitted.Probability;
%      [pf_lr,pdd_lr,Tlog,AUClog] = perfcurve(logical(Y),score_log,'1');
    %KNN
    model_randomforests  = fitcensemble(X,Y);
    %;(X,Y,'NumNeighbors',35);
    [~,score] = resubPredict(model_randomforests);
    [pf_randomforests,pdd_randomforests,Tsvm,AUCsvm] = perfcurve(logical(Y),score(:,logical(model_randomforests.ClassNames)),'true');
    
% <<<<<<< Updated upstream
%   pd_svm(i) = pdd_svm(find(pf_svm<=0.1, 1, 'last' ));
%      pd_lr(i) = pdd_lr(find(pf_lr<=0.1, 1, 'last' ));
%      pd_knn(i) = pdd_knn(find(pf_knn<=0.1, 1, 'last' ));
% =======
%     pd_svm(i) = pdd_svm(find(pf_svm<=0.1, 1, 'last' ));
%     pd_lr(i) = pdd_lr(find(pf_lr<=0.1, 1, 'last' ));


%     temp = find(0.09 < pf_randomforests & pf_randomforests <= 0.1,1,'last');
% %     aaaaa= pf_randomforests(temp(0))
% %     array_pfvalues(end+1) = aaaaa;
% %     pd_randomforests(i) = pdd_randomforests(temp);
    pd_randomforests(i) = pdd_randomforests(find(pf_randomforests<=0.1, 1, 'last' ));

% >>>>>>> Stashed changes
end

save('randomforests_2_dataset3.mat')