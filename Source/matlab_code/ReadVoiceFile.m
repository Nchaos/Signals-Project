clc
clear all

[m, Fs] = audioread('test file for signals.wav');
ts = 1/Fs;
m = m(:,1);
m = m';

[m2, Fs2] = audioread('voice2.wav');
ts2 = 1/Fs2;
m2 = m2(:,1);
m2 = m2';




Length = length(m);
t = (0 : Length - 1)/Fs;

Length2 = length(m2);
m2_t = (0 : Length2 -1)/Fs2;

M2 = fftshift(fft(m2, Length2));
M2_sig = abs(M2);
freqm2 = (-Length2/2 : Length2/2 -1)/(Length2/ts2);


M = fftshift(fft(m, Length));
M_sig = abs(M);
freqm = (-Length/2 : Length/2 -1)/(Length/ts);

B_m2 = 5000;
h2 = fir1(40,[B_m2*ts2]);

B_m = 5000;
h=fir1(40,[B_m*ts]);

fc = 40000;
s_dsb2 = m2.*sin(2*pi*fc*m2_t);
s_dsb = m.*cos(2*pi*fc*t);
lfft= length(t);
lfft_m2 = length(m2_t);
lfft = 2^ceil(log2(lfft)+1);
lfft_m2 = 2^ceil(log2(lfft_m2)+1);

S_dsb = fftshift(fft(s_dsb,lfft));
freqs = (-lfft/2:lfft/2-1)/(lfft*ts);
%am modulation

s_dem = s_dsb.*cos(2*pi*fc*t)*2;
S_dem=fftshift(fft(s_dem,lfft));

s_rec = filter(h,1,s_dem);
S_rec = fftshift(fft(s_rec,lfft));
%audiowrite('voiceOutput_demod.wav', s_dem, Fs);
figure, plot(t, m);
figure, plot(t, s_rec);
figure, plot(t, s_dsb);
%figure, plot(freq
%figure, plot(freqm, M_sig);
%figure, plot(freqs, abs(S_rec));



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
