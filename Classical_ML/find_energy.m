function energy = find_energy(signal,snr)
%     demodulated = 2*signal.*cos(2*pi*fc/fs.*samples);
%     bandpass = myLowpass(demodulated,120,fs);
%     y = reshape(signal,m,l);
    Y = fft(signal);
    abs_Y = abs(Y).^2;
    r = mean(abs_Y,1);
    energy = (2*snr)*sum(r);
end