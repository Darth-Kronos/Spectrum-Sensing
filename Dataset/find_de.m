function de = find_de(signal,beta)
    alpha = log(beta*(sum(abs(signal-mean(signal)).^beta))/length(signal))/beta;
    de = 1/beta - log(beta/(2*gamma(1/beta))) + alpha;
end