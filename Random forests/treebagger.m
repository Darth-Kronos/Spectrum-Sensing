clear all;
load('./SVM/data_set_10.mat');
train_X = data_set(:,[1,2,3]);
train_Y = data_set(:,4);
load('test.mat');
test_X = data_set(:,[1,2,3]);
test_Y = data_set(:,4);

costt=[0 1 1 0]
costt2=reshape(costt,2,2)
Mdl = TreeBagger(50,train_X,train_Y,'cost',costt2)

Yfit = predict(Mdl,test_X) 


p = 0:0.01:1;
pf = zeros(1,length(p));
pd = zeros(1,length(p));
for i=1:length(p)
    
    costt=[0 p(i) 1-p(i) 0]
    costt2=reshape(costt,2,2)
    Mdl = TreeBagger(30,train_X,train_Y,'cost',costt2)
    y1 = predict(Mdl,test_X)
    y=str2double(y1)
    pf(i) = sum(logical(y) & ~logical(test_Y))/(200-sum(test_Y));
    pd(i) = dot(y,test_Y)/sum(test_Y);
    view(Mdl.Trees{1},'Mode','graph')
end

plot(pf,pd)