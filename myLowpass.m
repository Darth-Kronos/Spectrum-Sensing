function y = myLowpass(x,fc,fs)
ts = 1/fs;
Nlpf = 50;
h = fir1(Nlpf,2*fc*ts);
y= filter(h,1,x);
end