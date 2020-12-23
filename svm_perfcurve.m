clear all
load('./Dataset/features_db_1_18.mat')
X = data_set(:,1);
Y = data_set(:,2);
mdlSVM = fitcsvm(X,Y,'Standardize',true);
mdlSVM = fitPosterior(mdlSVM);
[~,score_svm] = resubPredict(mdlSVM);
[Xsvm,Ysvm,Tsvm,AUCsvm] = perfcurve(logical(Y),score_svm(:,logical(mdlSVM.ClassNames)),'true');
plot(Xsvm,Ysvm)