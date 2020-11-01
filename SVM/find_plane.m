function [X,Y,Z,w0,b0] =  find_plane(model,data)
    features = data(:,(1:3));
    y = data(:,4);
    support_vectors = (features(model.IsSupportVector,:))';
    y_support = (y(model.IsSupportVector,:))';
    alpha = model.Alpha;
    w0 = zeros(3,1);
    for i = 1:size(alpha,1)
        w0 = w0 + alpha(i,1) * y_support(1,i) .* support_vectors(:,i);
    end
    b0 = model.Bias;
    xgrid=[0:0.01:1];
    ygrid=[0:0.01:1];
    [X, Y]=meshgrid(xgrid, ygrid);
    Z=(-b0-w0(1)*X-w0(2)*Y)/w0(3);
end