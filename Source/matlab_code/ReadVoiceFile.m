clc
clear all

[m, Fs] = audioread('test file for signals.wav');
ts = 1/Fs;
m = m(:,1);
m = m';

Length = length(m);
t = (0 : Length - 1)/Fs;


M = fftshift(fft(m, Length));
M_sig = abs(M);
freqm = (-Length/2 : Length/2 -1)/(Length/ts);



B_m = 5000;
h=fir1(40,[B_m*ts]);

fc = 40000;
s_dsb = m.*cos(2*pi*fc*t);
lfft= length(t);
lfft = 2^ceil(log2(lfft)+1);
S_dsb = fftshift(fft(s_dsb,lfft));
freqs = (-lfft/2:lfft/2-1)/(lfft*ts);
%am modulation

s_dem = s_dsb.*cos(2*pi*fc*t)*2;
S_dem=fftshift(fft(s_dem,lfft));

s_rec = filter(h,1,s_dem);
S_rec = fftshift(fft(s_rec,lfft));

figure, plot(t, m);
figure, plot(t, s_rec);
figure, plot(freqm, M_sig);
figure, plot(freqs, abs(S_rec));



%{
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
figure, plot(f2, abs(mody2_fft))
%}
