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

m2(numel(m))=0;


Length = length(m);
t = (0 : Length - 1)/Fs;
t2 = (0:Length -1)/Fs2;


M = fftshift(fft(m, Length));
M_sig = abs(M);
freqm = (-Length/2 : Length/2 -1)/(Length/ts);

M2 = fftshift(fft(m2, Length));
M2_sig = abs(M2);
%freqm2 = (-Length/2 : Length/2 -1)/(Length/ts);



B_m = 5000;
h=fir1(40,[B_m*ts]);

fc = 40000;
s_qam = (m).*cos(2*pi*fc*t)+(m2).*sin(2*pi*fc*t);
Lfft=length(t);   % defining DFT (or FFT) size
Lfft=2^ceil(log2(Lfft)+1);  % increasing Lfft by factor of 2 

S_qam=fftshift(fft(s_qam,Lfft)); % obtaining frequency domain modulated signal
freqs=(-Lfft/2:Lfft/2-1)/(Lfft*ts);% Defining the frequency axis for the frequency domain DSB modulated signal

s_dem1=s_qam.*cos(2*pi*fc*t)*2; % i.e taking envelope when signal is positive and zero when signal is negative
S_dem1=fftshift(fft(s_dem1,Lfft)); % Demodulatede signal in frequency domain
s_dem2=s_qam.*sin(2*pi*fc*t)*2; % i.e taking envelope when signal is positive and zero when signal is negative
S_dem2=fftshift(fft(s_dem2,Lfft)); % Demodulatede signal in frequency domain


figure, plot(t,m);
figure, plot(t,m2);
figure, plot(t, s_qam);
figure, plot(t, s_dem1);
figure, plot(t, s_dem2);



%{
s_dsb = m.*cos(2*pi*fc*t);
s_dsb2 = m2.*sin(2*pi*fc*t);
lfft= length(t);
lfft = 2^ceil(log2(lfft)+1);
S_dsb = fftshift(fft(s_dsb,lfft));
S_dsb2 = fftshift(fft(s_dsb2,lfft));
freqs = (-lfft/2:lfft/2-1)/(lfft*ts);


%am modulation

s_dem = s_dsb.*cos(2*pi*fc*t)*2;
s_dem2 = s_dsb.*sin(2*pi*fc*t)*2
S_dem=fftshift(fft(s_dem,lfft));

s_rec = filter(h,1,s_dem);
S_rec = fftshift(fft(s_rec,lfft));
%}
audiowrite('voiceOutput_sdem1.wav', s_dem1, Fs);
%figure, plot(t, m);
%figure, plot(t, s_rec);
%figure, plot(t, s_dsb);
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
