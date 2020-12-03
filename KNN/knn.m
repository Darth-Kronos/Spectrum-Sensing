clear all
load('./Dataset/features_db_1_18.mat');
train_X = data_set(:,1);
train_Y = data_set(:,2);
% load('test.mat');
test_X = data_set(:,1);
test_Y = data_set(:,2);
p = 0:0.001:1;
pf = zeros(1,length(p));
pd = zeros(1,length(p));
pe = zeros(1,length(p));
for i=1:length(p)
    cost = [0 p(i); 1-p(i) 0];
    model = fitcknn(train_X,train_Y,'cost',cost,'NumNeighbors',15);
    
    y = predict(model,test_X);
    pf(i) = sum(logical(y) & ~logical(test_Y))/(length(test_Y)-sum(test_Y));
    pd(i) = dot(y,test_Y)/sum(test_Y);
    pe(i) = p(i)*pf(i) + (1-p(i))*(1-pd(i));
end

plot(pf,pd)
xlabel('Probability of False alarm');ylabel('Probability of detection');