[m, Fs] = wavread('test file for signals.wav');
m = m(:,1);
length = length(m);
t = (0: length - 1)/Fs;
plot(t, m);
m = fftshift(fft(m, length));
M_mag = abs(m);
df = (-length/2 : length/2 -1)*(Fs/length);
plot(df, M_mag);


fSampling = Fs;
yt = m;
fc = 15000;

y= yt.*cos(2*pi*fc*t);

mody_fft = fft(y);
n = numel(mody_fft); 
f = 0:fSampling/n:fSampling*(n-1)/n;

y2 = y.*cos(2*pi*fc*t);
mody2_fft = fft(y2);
n2 = numel(mody2_fft);
f2 = 0:fSampling/n2:fSampling*(n2-1)/n2;
plot(f2, abs(mody2_fft))

