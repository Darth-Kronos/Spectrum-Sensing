clear all;
load('./Dataset/dataset_1.mat');
raw_data = Pd_rawData(:,1);
snr_db = -10:1:1;
pd = zeros(1,length(snr_db));
for i=1:length(snr_db)
    data_set = preprocessing(raw_data,snr_db(i));
    p = 0:0.01:1;
    for j=1:length(p)
        costt=[0 p(j) 1-p(j) 0];
        costt2=reshape(costt,2,2);
        train_X = data_set(:,1);
        train_Y = data_set(:,2);
        Mdl = TreeBagger(30,train_X,train_Y,'cost',costt2);
        y1 = predict(Mdl,train_X);
        y=str2double(y1);
        pf = sum(logical(y) & ~logical(train_Y))/(length(train_Y)-sum(train_Y));
        p_d = dot(y,train_Y)/sum(train_Y);
        if(pf >= 0.1 && pf <=0.15)
          pd(i) = p_d;
        end
    end
end

plot(snr_db,pd)