function de = find_de(signal,beta)
%     demodulated = 2*signal.*cos(2*pi*fc/fs.*samples);
%     bandpass = myLowpass(demodulated,120,fs);
%     y = reshape(signal,m,l);
    alpha = log(beta*(sum(abs(signal-mean(signal)).^beta))/length(signal))/beta;
    de = 1/beta - log(beta/(2*gamma(1/beta))) + alpha;
end