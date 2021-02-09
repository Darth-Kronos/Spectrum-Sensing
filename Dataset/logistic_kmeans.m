clear all;
load('dataset_1.mat');
raw_data = Pd_rawData(:,1);
snr_db = -30:1:-10;

pd_lr = ones(1,length(snr_db));
pd_lr_de = ones(1,length(snr_db));
pd_km = ones(1,length(snr_db));
pd_km_de = ones(1,length(snr_db));
beta = 1;

for i=1:length(snr_db)
    fprintf('Sl no. SNR: %d\n',i);
    %% DE
    data_set = preprocessing_de(raw_data,snr_db(i),beta);
    X = data_set(:,1);
    Y = data_set(:,2);
    fprintf('trianing1 \n');
    %Logistic
     model_lr = fitglm(X,Y,'Distribution','binomial','Link','logit');
     score_log = model_lr.Fitted.Probability;
     [pf_lr,pdd_lr,~,~] = perfcurve(Y,score_log,'1');
     pd_lr_de(i) = pdd_lr(find(pf_lr<=0.1, 1, 'last' ));
     %k-means
     [pdd_km,pff_km] = km(X,Y);
     pd_km_de(i) = pdd_km(find(pff_km<=0.1, 1, 'first' ));
     %plot(pff_km,pdd_km);break;
    
    %% ED
    %Logistic
    data_set2 = preprocessing(raw_data,snr_db(i),beta);
    X2 = data_set2(:,1);
    Y2 = data_set2(:,2);
    fprintf('trianing2 \n');
     model_lr = fitglm(X2,Y2,'Distribution','binomial','Link','logit');
     score_log = model_lr.Fitted.Probability;
     [pf_lr,pdd_lr,~,~] = perfcurve(Y2,score_log,'1');
     pd_lr(i) = pdd_lr(find(pf_lr<=0.1, 1, 'last' ));
     %k-means
     [pdd_km,pff_km] = km(X2,Y2);
     pd_km(i) = pdd_km(find(pff_km<=0.1, 1, 'first' ));

end
save('all_lr_km_1_final.mat')


function [pd,pf] = km(X,Y)
[~,c] = kmeans(X,2);
c1 = c(1,:);
c2 = c(2,:);
if (c1*c1')>(c2*c2')
    c1 = c(2,:);
    c2 = c(1,:);
end
line = c2 - c1;
mag = sqrt(line*line');
unit_line = line/mag;
v_1 = X-c1;%c1-X
v_2 = X-c2;
d_1 = (v_1*line')/mag;
d_2 = (v_2*line')/mag;
mini = min(d_1);
new_scale = d_1 - mini;
    
tmin = min(new_scale);
tmax = max(new_scale);

threshold = linspace(tmin,tmax,1000);
pf = zeros(1,length(threshold));
pd = zeros(1,length(threshold));

for i=1:length(threshold)
    y_estimate = new_scale > threshold(i);
    y = Y;
    
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
    %if(pf(i) > 0.05 && pf(i) < 0.1)
     %       pdd(ii) = pd(i);
      %      break;
      %  end
        
end
end