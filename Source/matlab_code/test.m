clc;
clear all;

Fs = 350;
ts = 1/Fs;
Fs_slower = 150;
t = 0:1/Fs:1;
t_slower = 0:1/Fs_slower:1;
f = 5;
m = sin(2*pi*f*t);
m2 = cos(2*pi*f*t);
m3 = sawtooth(2*pi*f*t);
m4 = square(2*pi*f*t);

sin_saw5 = sin(2*pi*f*t) - (1/2)*sin(4*pi*f*t) +(1/3)*sin(6*pi*f*t) - (1/4)*sin(8*pi*f*t) + (1/5)*sin(10*pi*f*t);
sin_saw7 = sin(2*pi*f*t + 0.5) - (1/2)*sin(4*pi*f*t + 0.5) +(1/3)*sin(6*pi*f*t + 0.5) - (1/4)*sin(8*pi*f*t + 0.5) + (1/5)*sin(10*pi*f*t + 0.5) - (1/6)*sin(12*pi*f*t + 0.5) + (1/7)*sin(14*pi*f*t + 0.5);

sin_square7 = sin(2*pi*f*t) +(1/3)*sin(6*pi*f*t) + (1/5)*sin(10*pi*f*t) + (1/7)*sin(14*pi*f*t) +(1/9)*sin(18*pi*f*t) ;
sin_square7s = sin(2*pi*f*t_slower) +(1/3)*sin(6*pi*f*t_slower) + (1/5)*sin(10*pi*f*t_slower) + (1/7)*sin(14*pi*f*t_slower) +(1/9)*sin(18*pi*f*t_slower) ;



X5th = fftshift(fft(sin_saw5));
X5thMag = abs(X5th);
X7th = fftshift(fft(sin_saw7));
X7thMag = abs(X7th);

X7thSQ = fftshift(fft(sin_square7));
X7thSQMag = abs(X7thSQ);

df = -Fs/2:1:Fs/2;

fc = 4000; 
m_am = (sin_saw7).*cos(2*pi*fc*t);
Lfft = length(t);
Lfft=2^ceil(log2(Lfft));
M_am=fftshift(fft(m_am,Lfft));
freqs=(-Lfft/2:Lfft/2-1)/(Lfft*ts);


figure, plot(t, m_am);
title('Modulated Square Wave');
xlabel('Time (s)');
ylabel('Amplitude');

figure, plot(freqs, abs(M_am));
title('Modulated Square Wave - Frequency');
xlabel('Frequency (Hz)');
ylabel('Amplitude');



figure(1)
subplot(121); plot(t_slower,sin_square7s);
title('Square Harmonic Synthesis: 9th Harmonic 150Hz');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(122); plot(t,sin_square7);
title('Square Harmonic Synthesis: 9th Harmonic 300Hz');
xlabel('Time (s)');
ylabel('Amplitude');

figure(2)
subplot(121); plot(df,abs(X5thMag));
title('Sawtooth Harmonic Synthesis: 5th Harmonic');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(122); plot(df,abs(X7thMag));
title('Sawtooth Harmonic Synthesis: 7th Harmonic');
xlabel('Frequency (Hz)');
ylabel('Amplitude');



X = fftshift(fft(m));
XMag = abs(X);

X2 = fftshift(fft(m2));
XMag2 = abs(X2);

X3 = fftshift(fft(m3));
XMag3 = abs(X3);


X4 = fftshift(fft(m3));
XMag4 = abs(X4);

df = -Fs/2:1:Fs/2;




figure, plot(df,XMag3);
title('Sawtooth - Frequency')
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%{
figure(1)
subplot(221); plot(t,m) 
title('Sine')
xlabel('Time (s)');
ylabel('Amplitude');


subplot(222); plot(t,m2)
title('Cosine')
xlabel('Time (s)');
ylabel('Amplitude');

subplot(223); plot(t, m3)
title('Sawtooth')
xlabel('Time (s)');
ylabel('Amplitude');

subplot(224); plot(t, m4)
title('Square')
xlabel('Time (s)');
ylabel('Amplitude');
%%%%%%%%%%%%%%%%%%%%

figure(2)
subplot(221); plot(df,XMag) 
title('Sine - Frequency')
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(222); plot(df,XMag2)
title('Cosine - Frequency')
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(223); plot(df,XMag3)
title('Triangle/Sawtooth - Frequency')
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(224); plot(df,XMag4)
title('Square - Frequency')
xlabel('Frequency (Hz)');
ylabel('Amplitude');

%}
