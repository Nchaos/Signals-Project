clc
clear all

[m, Fs] = audioread('test file for signals.wav');
Fs = 40000;
ts = 1/Fs; %generate the time vector from the sampling rate Fs
m = m(:,1); %assign the m vector to variable m 
m = m'; %Taking the transpose of m

[m2, Fs2] = audioread('voice2.wav');
ts2 = 1/Fs2;
m2 = m2(:,1);
m2 = m2';
m2(numel(m))=0;


Length = length(m); % get the length of the voice message
t = (0 : Length - 1)/Fs;
t2 = (0:Length -1)/Fs2;

B_m = 5000;
h=fir1(40,[B_m*ts]);

fc = 40000;
%M = fftshift(fft(m, Length));
%M_sig = abs(M);

%M2 = fftshift(fft(m2, Length));
%M2_sig = abs(M2);
%freqm2 = (-Length/2 : Length/2 -1)/(Length/ts);
m_mod = m.*cos(2*pi*fc*t);
Lfft=length(t);   % defining DFT (or FFT) size
Lfft=2^ceil(log2(Lfft)+1);  % increasing Lfft  by factor of 2 
M=fftshift(fft(m_mod,Lfft)); % obtaining frequency domain modulated signal
M_sig = abs(M);

m2_mod = m2.*cos(2*pi*fc*t);
Lfft=length(t);   % defining DFT (or FFT) size
Lfft=2^ceil(log2(Lfft)+1);  % increasing Lfft  by factor of 2 
M2=fftshift(fft(m2_mod,Lfft)); % obtaining frequency domain modulated signal
M2_sig = abs(M2);

%freqs = (-Lfft/2 : Lfft/2 -1)/(Lfft*ts);
%{
figure, plot(t, m_mod);
title('Modulated Voice Wave (Nick)');
xlabel('Time (s)');
ylabel('Amplitude');
figure, plot(t, m2_mod);
title('Modulated Voice Wave (Andy)');
xlabel('Time (s)');
ylabel('Amplitude');
%}


s_qam = (m).*cos(2*pi*fc*t)+(m2).*sin(2*pi*fc*t);

%Attenuation by a factor of 0.5
s_qam_channel = s_qam.*0.5;

%inject random Gaussian white noise into signal 
s_qam_channel_noise = awgn(s_qam_channel,10,'measured');

Lfft=length(t);   % defining DFT (or FFT) size
Lfft=2^ceil(log2(Lfft)+1);  % increasing Lfft  by factor of 2 
S_qam=fftshift(fft(s_qam_channel_noise,Lfft)); % obtaining frequency domain modulated signal

freqs=(-Lfft/2:Lfft/2-1)/(Lfft*ts);% Defining the frequency axis for the frequency domain DSB modulated signal
%{
figure(1)
subplot(131); plot(t, s_qam);
title('QAM of Two Voice Messages');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(132);plot(t, s_qam_channel);
title('QAM of Two Voice Messages After Attenuation');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(133);plot(t, s_qam_channel_noise);
title('QAM of Two Voice Messages After Random Gaussian Noise');
xlabel('Time (s)');
ylabel('Amplitude');


figure, plot(freqs, abs(S_qam));
title('QAM of Two Voice Messages Channel Attenuation & Noise - Frequency');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%}
s_dem1=s_qam_channel_noise.*cos(2*pi*fc*t)*2; % i.e taking envelope when signal is positive and zero when signal is negative
S_dem1=fftshift(fft(s_dem1,Lfft)); % Demodulatede signal in frequency domain
s_dem2=s_qam_channel_noise.*sin(2*pi*fc*t)*2; % i.e taking envelope when signal is positive and zero when signal is negative
S_dem2=fftshift(fft(s_dem2,Lfft)); % Demodulatede signal in frequency domain



s_rec1=filter(h,1,s_dem1);
S_rec1=fftshift(fft(s_rec1,Lfft)); % Demodulatede signal in frequency domain
s_rec2=filter(h,1,s_dem2);
S_rec2=fftshift(fft(s_rec2,Lfft)); % Demodulatede signal in frequency domain

figure, plot(t, s_rec1);
title('QAM: Low-Pass FIR Filter on Demodulated Voice - Nick');
xlabel('Time (s)');
ylabel('Amplitude');
figure, plot(t,s_rec2);
title('QAM: Low-Pass FIR Filter on Demodulated Voice - Andy');
xlabel('Time (s)');
ylabel('Amplitude');

figure, plot(freqs, abs(S_rec1));
title('QAM: Low-Pass FIR Filter on Demodulated Voice (Nick) - Frequency');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
figure, plot(freqs,abs(S_rec2));
title('QAM: Low-Pass FIR Filter on Demodulated Voice (Andy) - Frequency');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

%figure, plot(t,m);
%figure, plot(t,m2);
%figure, plot(t, s_qam);
%figure, plot(t, s_dem1);
%figure, plot(t, s_dem2);

audiowrite('NickvoiceOutput_sdem1-final.wav', s_dem1, Fs);
audiowrite('AndyvoiceOutput_sdem2-final.wav', s_dem2, Fs);
audiowrite('NickvoiceOutput_srec1-final.wav', s_rec1, Fs);
audiowrite('AndyvoiceOutput_srec2-final.wav', s_rec2, Fs);


figure, plot(t,m) 
title('Nick''s Voice Message')
xlabel('Time (s)');
ylabel('Amplitude');
figure, plot(t,m2) 
title('Andy''s Voice Message')
xlabel('Time (s)');
ylabel('Amplitude');


figure(1)
subplot(221); plot(t,m2) 
title('Andy''s Voice Message')
xlabel('Time (s)');
ylabel('Amplitude');

subplot(222); plot(t,s_qam)
title('Nick & Andy Voice QAM')
xlabel('Time (s)');
ylabel('Amplitude');

subplot(223); plot(t, s_dem2)
title('QAM Demodulation - Andy''s Voice')
xlabel('Time (s)');
ylabel('Amplitude');

subplot(224); plot(t,s_rec2)
title('Filter on Demodulated Voice Signal - Andy')
xlabel('Time (s)');
ylabel('Amplitude');
%{
%%%%%%%%%%%%%%

figure(2)
subplot(221); plot(t,m2)
title('Andy''s Voice Message')

subplot(222); plot(t,s_qam)
title('s\_qam')

subplot(223); plot(t, s_dem2)
title('s\_dem2')

subplot(224); plot(t,s_rec2)
title('s\_rec2')

figure(3)
subplot(221); plot(freqm,abs(M))
title('M1\_sig')

subplot(222); plot(freqs,abs(S_qam))
title('S\_qam')

subplot(223); plot(freqs, abs(S_dem1))
title('S\_dem1')

subplot(224); plot(freqs,abs(S_rec1))
title('S\_rec1')


figure(4)
subplot(221); plot(freqm,abs(M2))
title('M2\_sig')

subplot(222); plot(freqs,abs(S_qam))
title('S\_qam')

subplot(223); plot(freqs, abs(S_dem2))
title('S\_dem2')

subplot(224); plot(freqs,abs(S_rec2))
title('S\_rec2')
%}
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
%}
