function energy = find_energy(signal,m,l,snr)
    y = reshape(signal,m,l);
    Y = abs(fft(y)).^2;
    r = mean(Y,1);
    energy = (2*snr).*sum(r);
end