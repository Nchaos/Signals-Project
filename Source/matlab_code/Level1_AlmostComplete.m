F0 = 2000;  
fSampling = 30000;
tSampling = 1/fSampling;
t = -0.005:tSampling:0.005;

yt = sin(2*pi*F0*t); 
%figure, plot(t, yt)
%grid off


fc = 15000; 
y= yt.*cos(2*pi*fc*t); 
%plot(t, y)

mody_fft = fft(y);
n = numel(mody_fft); 
f = 0:fSampling/n:fSampling*(n-1)/n;
%plot(f,abs(mody_fft))

y2 = y.*cos(2*pi*fc*t);
mody2_fft = fft(y2);
n2 = numel(mody2_fft);
f2 = 0:fSampling/n2:fSampling*(n2-1)/n2;
plot(f, abs(mody2_fft));
%grid minor
%plot(t, ifourier(mody2_fft))
%plot(t, y2)

d = fdesign.lowpass('Fc',.25);
Hd = design(d,'equiripple');
fvtool(Hd);
y3 = filter(Hd,y2);
y3_mod = fft(y3);
n3 = numel(y3_mod);
f3 = 0:fSampling/n3:fSampling*(n3-1)/n3;

plot(f3, abs(y3_mod))
