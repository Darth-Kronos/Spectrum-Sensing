function energy = find_energy(signal,fc,fs,samples,m,l,snr)
    demodulated = signal.*cos(2*pi*fc/fs.*samples);
    bandpass = myLowpass(demodulated,20,fs);
    y = reshape(bandpass,m,l);
    Y = fft(y,m); % M point fft
    abs_Y = abs(Y).^2; 
    r = mean(abs_Y,2);
    energy = (2*snr)*sum(r);
end