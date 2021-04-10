clear all;close all;clc;
load('./Dataset/dataset_3.mat');
raw_data = Dataset3((1:10000),1);
snr_db = -16;
beta = [0.75 1 2];
pd_final = zeros(size(beta,2),4);
puff = 0.1;

for i=1:length(beta)
% DE
data_set1 = preprocessing_de(raw_data,snr_db,beta(i));
X1 = data_set1(:,1);
Y1 = data_set1(:,2);
%KNN
model_knn  = fitcknn(X1,Y1,'NumNeighbors',35);
[~,score] = resubPredict(model_knn);
[pf_knn,pdd_knn,~,~] = perfcurve(logical(Y1),score(:,logical(model_knn.ClassNames)),'true');
pd_final(i,1) = pdd_knn(find(pf_knn<=puff, 1, 'last' ));


%SVM
mdlSVM = fitcsvm(X1,Y1,'Standardize',true);
mdlSVM = fitPosterior(mdlSVM);
[~,score_svm] = resubPredict(mdlSVM);
[pf_svm,pdd_svm,~,~] = perfcurve(logical(Y1),score_svm(:,logical(mdlSVM.ClassNames)),'true');
pd_final(i,2) = pdd_svm(find(pf_svm<=puff, 1, 'last' ))
disp(i);
%Logistic
model_lr = fitglm(X1,Y1,'Distribution','binomial','Link','logit');
score_log = model_lr.Fitted.Probability;
[pf_lr,pdd_lr,~,~] = perfcurve(Y1,score_log,'1');
pd_final(i,3) = pdd_lr(find(pf_lr<=puff, 1, 'last' ))
disp(i);
RF
model_randomforests = fitcensemble(X1,Y1);
[~,score] = resubPredict(model_randomforests);
[pf_randomforests,pdd_randomforests_de,~,~] = perfcurve(logical(Y1),score(:,logical(model_randomforests.ClassNames)),'true');
pd_final(i,4) = pdd_randomforests_de(find(pf_randomforests<=puff, 1, 'last' ))
plot(pf_randomforests,pdd_randomforests_de);

end

save('data2_pd_0.1_16_0.75.mat');