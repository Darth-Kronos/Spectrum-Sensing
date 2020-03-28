clear all;
close all;
tr = 1/4000;
t=0:tr:8191/4000;
Ts = 1/(4000);
fm = 16;
f0 = 512;
x = 2.*cos(2*pi*fm*t).*cos(2*pi*f0*t);

Nfactor = round(Ts/tr);

p= ones(1,length(x));
p= downsample(p,Nfactor);
p=upsample(p,Nfactor);
p=p(1:length(x));
xs = x.*p;
xn = reshape(xs,256,32);
h = hamming(256);
xn = h.*xn;
Xn = fft(xn);