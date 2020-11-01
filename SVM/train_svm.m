function model = train_svm(data)
    model = fitcsvm(data(:,(1:3)),data(:,4),'BoxConstraint',0.1,'ClassNames',[-1,1]);
end