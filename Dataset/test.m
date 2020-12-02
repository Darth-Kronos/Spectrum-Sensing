clear all;
load('./Dataset/dataset_1.mat');
raw_data = Pd_rawData(:,1);
snr_db = -40:1:-12;
pd = ones(1,length(snr_db));
for i=1:length(snr_db)
    data_set = preprocessing(raw_data,snr_db(i));
    X = data_set(:,1);
    Y = data_set(:,2);
    PD = 0.80 ;  % percentage 80%
    Ptrain = X(1:round(PD*length(X)),:) ; Ttrain = Y(1:round(PD*length(Y))) ;
    Ptest = X(round(PD*length(X)):end,:) ;Ttest = Y(round(PD*length(Y)):end) ;
    p = 0:0.01:1;
    
    for j=1:length(p)
%         costt=[0 p(j) 1-p(j) 0];
%         costt2=reshape(costt,2,2);
%         train_X = data_set(:,1);
%         train_Y = data_set(:,2);
%         Mdl = TreeBagger(10,train_X,train_Y,'cost',costt2);
%         y1 = predict(Mdl,train_X);
%         y=str2double(y1);
%         pf = sum(logical(y) & ~logical(train_Y))/(length(train_Y)-sum(train_Y));
%         p_d = dot(y,train_Y)/sum(train_Y);
        cost = [0 p(j); 1-p(j) 0];
        model = fitcnb(Ptrain,Ttrain,'cost',cost);
    
        y = predict(model,Ptest);
        pf = sum(logical(y) & ~logical(Ttest))/(length(Ttest)-sum(Ttest));
        p_d = dot(y,Ttest)/sum(Ttest);
%         pe(i) = p(i)*pf(i) + (1-p(i))*(1-pd(i));
        if(pf >= 0.1 && pf <=0.15)
          pd(i) = p_d;
          break
        end
    end
end

plot(snr_db,pd)