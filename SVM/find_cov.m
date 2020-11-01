function [cov,eigen] = find_cov(signal)
    Ns = ceil(length(signal)/10);
    mean_signal = mean(signal);
    signal = signal - mean_signal;
    ry = zeros(Ns,Ns);
    for i = 1:Ns
        for j = i:Ns
            ry(i,j) = find_lambda(signal,i-1);
            if(i ~= j)
                ry(j,i) = ry(i,j);
            end
        end
    end
    T1 = sum(abs(ry),'all')/Ns;
    T2 = trace(abs(ry))/Ns;
    cov = T1/T2;
    vec = eig(ry);
    eigen = max(vec)/min(vec);
end

function lam = find_lambda(signal,L)
    Ns = length(signal);
    lam = 0;
    for i =1:Ns-L
        lam = lam + signal(i)*conj(signal(i+L));  
    end
    lam = lam/Ns; 
end

