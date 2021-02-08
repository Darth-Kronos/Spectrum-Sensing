clc;
close all;
clear all;

% snrr = [-30:1:-2];ii=1;
% pdd=zeros(1,size(snrr,2));
% for snrdb = snrr
%     load('/home/akshay/Desktop/Spectrum-Sensing/Dataset/dataset_1.mat');disp(snrdb);
%     avg_data = Pd_rawData(:,1);
%     data = (avg_data - mean(avg_data))./sqrt(var(avg_data));
%     snr = 10^(snrdb/10); % snr = -18 dB
%     N = length(data);
%     M = 25000;
%     data_set = zeros(2*M,2);
%     for i =1:M
%         noise = randn(1,N)';
%         signal = sqrt(snr).*data + randn(1,N)';
%         obs_H0 = find_energy(noise,snr);
%         obs_H1 = find_energy(signal,snr);
%     
%         data_set(i,1) = obs_H0;
%         data_set(i+M,1) = obs_H1;
%     
%         data_set(i,2) = 0;
%         data_set(i+M,2) = 1;
%     
%         %disp(i);
%     end
% 
%     data_set = data_set(randperm(size(data_set, 1)), :);
%     data_set(:,1) = rescale(data_set(:,1));
%     data = data_set(:,1);
%     [idx,c] = kmeans(data,2);
%     %mid = min(c(1,1)+c(2,1)) + c(1,1)+c(2,1);
%     c1 = c(1,:);
%     c2 = c(2,:);
%     if (c1*c1')>(c2*c2')
%         c1 = c(2,:);
%         c2 = c(1,:);
%     end
%     line = c2 - c1;
%     mag = sqrt(line*line');
%     unit_line = line/mag;
%     v_1 = c1-data;
%     v_2 = c2-data;
%     d_1 = (v_1*line')/mag;
%     d_2 = (v_2*line')/mag;
%     mini = min(d_1);
%     new_scale = d_1 - mini;
%     
%     tmin = min(new_scale);
%     tmax = max(new_scale);
% 
%     threshold = linspace(tmin,tmax,10000);
%     pf = zeros(1,length(threshold));
%     pd = zeros(1,length(threshold));
% 
%     for i=1:length(threshold)
%         y_estimate = new_scale > threshold(i);
%         y = data_set(:,2);
%     
%         pd(i) = 0;
%         pf(i) = 0;
%         for j =1:size(y_estimate,1)
%             if(y_estimate(j))
%                 if(y(j))
%                     pd(i) = pd(i) +1;
%                 end
%             end
%             if(y_estimate(j)==1)
%                 if((y(j)==0))
%                     pf(i) = pf(i) + 1;
%                 end
%             end  
%         end
%         pd(i) = pd(i)/sum(y==1,1);
%         pf(i) = pf(i)/sum(y==1,1);
%         if(pf(i) > 0.05 && pf(i) < 0.1)
%             pdd(ii) = pd(i);
%             break;
%         end
%         
%     end
%     %figure(abs(snrr(ii)));
%     %plot(pf,pd);
%     %o=1;
%     %while(pf(o) < 0.1)
%     %    o=o+1;
%     %end
%     %disp(pf(o));disp(pd(o));
%     %o=o-1;
%     ii=ii+1;
%  
% end
% plot(snrr,pdd);   
%     
   

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
v_1 = c1-data;
v_2 = c2-data;
d_1 = (v_1*line')/mag;
d_2 = (v_2*line')/mag;
mini = min(d_1);
new_scale = d_1 - mini;
    
tmin = min(new_scale);
tmax = max(new_scale);

threshold = linspace(tmin,tmax,10000);
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    