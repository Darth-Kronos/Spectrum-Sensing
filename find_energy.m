function energy = find_energy(signal,m,l,snr)
    y = reshape(signal,m,l);
    Y = fft(y,m); % M point fft
    abs_Y = abs(Y).^2; 
    r = mean(abs_Y,1);
    energy = (2*snr).*sum(r);
end