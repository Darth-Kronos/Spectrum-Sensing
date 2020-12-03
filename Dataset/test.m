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
    train_x = X(1:round(PD*length(X)),:) ; train_y = Y(1:round(PD*length(Y))) ;
    test_x = X(round(PD*length(X)):end,:) ;test_y = Y(round(PD*length(Y)):end) ;
    p = 0:0.01:1;
    for j=1:length(p)
        cost = [0 p(j); 1-p(j) 0];
%         model = fitcnb(Ptrain,Ttrain,'cost',cost);
        model = fitcknn(train_x,train_y,'cost',cost,'NumNeighbors',15);
        y = predict(model,test_x);
        pf = sum(logical(y) & ~logical(test_y))/(length(test_y)-sum(test_y));
        p_d = dot(y,test_y)/sum(test_y);
%         pe(i) = p(i)*pf(i) + (1-p(i))*(1-pd(i));
        if(pf >= 0.1 && pf <=0.15)
          pd(i) = p_d;
          break
        end
    end
end

plot(snr_db,pd)