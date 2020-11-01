clc;
close all;
load('data_set_10.mat');
leng = length(data_set);
data_roc = data_set;
for i = 1:leng
    if(data_set(i,4) == 0)
        data_set(i,4) = -1;
    end
end

model = train_svm(data_set);
[X,Y,Z,w0,b0] = find_plane(model,data_set);


surf(X, Y, Z);
hold on
for i=1:size(data_set,1)
    if(data_set(i,4) == 1)
        scatter3(data_set(i,1),data_set(i,2),data_set(i,3),'MarkerFaceColor','red');
        hold on
    else
        scatter3(data_set(i,1),data_set(i,2),data_set(i,3),'MarkerFaceColor','blue');
        hold on
    end
    
end
xlabel('energy');ylabel('T1/T2');zlabel('Lmax/Lmin');


tmax = 0;
tmin = -5;
threshold = linspace(tmin,tmax,10000);
pf = zeros(1,length(threshold));
pd = zeros(1,length(threshold));

for i=1:length(threshold)
    y_estimate = data_roc(:,(1:3)) * w0 + threshold(i) >= 0;
    y = data_roc(:,4);
    
    pd(i) = 0;
    pf(i) = 0;
    for j =1:size(y_estimate,1)
        if(y_estimate(j))
            if(y(j))
                pd(i) = pd(i) +1;
            end
        end
        if(y_estimate(j)==1)
            if((y(j)==0))
                pf(i) = pf(i) + 1;
            end
        end   
    end
    pd(i) = pd(i)/sum(y==1,1);
    pf(i) = pf(i)/sum(y==1,1);
        
end

figure('Name','pd_vs_pfa');
plot(pf,pd);
xlabel('Pfa');ylabel('Pd');
        
