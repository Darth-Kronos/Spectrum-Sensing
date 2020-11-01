function y = myLowpass(x,cut_off,fs)
ts = 1/fs;
Nlpf = 50;
h = fir1(Nlpf,2*cut_off*ts);
y= filter(h,1,x);
end