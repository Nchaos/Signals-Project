%%% Illustrate QAM modulation  using triangl function and triplesinc
%%% function
%%% Defining message signal as a triangle signal, in real life however, this
%%% could be anything like voice signal etc. that we would want to transmit
function ExampleQAMdemfilt
clear all;
clf;

ts=10^(-4);
t=-0.04:ts:0.04;
Ta=0.01;

% Use triangl and triplesinc functions to generate two message signals of
% different shapes and spectra
m_sig1=triangl((t+0.01)/0.01)-triangl((t-0.01)/0.01);
m_sig2=triplesinc(t,Ta);

Lm_sig=length(m_sig1);
Lfft=length(t);   % defining DFT (or FFT) size
Lfft=2^ceil(log2(Lfft))  % making Lfft a power of 2 since this makes the fft algorithm work fast
M1_sig=fftshift(fft(m_sig1,Lfft))  % i.e. calculating the frequency domain message signal,
                                 % fft algorithm calculates points from ) to Lfft-1, hence we use fftshift on this
                                 % result to order samples from -Lfft/2 to Lfft/2 -1 
M2_sig=fftshift(fft(m_sig2,Lfft)) 
freqm=(-Lfft/2:Lfft/2-1)/(Lfft*ts) % Defining the frequency axis for the frequency domain DSB modulated signal
B_m=150;
h=fir1(40,[B_m*ts]) % defining a FIR filter of order 40 and cutoff frequency B_m*ts

%%% QAM Signal modulation
fc=300; % carrier frequency
s_qam=(m_sig1).*cos(2*pi*fc*t)+(m_sig2).*sin(2*pi*fc*t) % recall QAM modulation works by multiplying the two message signals by cos and sin functions respectively
Lfft=length(t);   % defining DFT (or FFT) size
Lfft=2^ceil(log2(Lfft)+1)  % increasing Lfft by factor of 2 

S_qam=fftshift(fft(s_qam,Lfft)); % obtaining frequency domain modulated signal
freqs=(-Lfft/2:Lfft/2-1)/(Lfft*ts) % Defining the frequency axis for the frequency domain DSB modulated signal


%%% Demodulation begins by using a rectifier 
s_dem1=s_qam.*cos(2*pi*fc*t)*2 % i.e taking envelope when signal is positive and zero when signal is negative
S_dem1=fftshift(fft(s_dem1,Lfft)); % Demodulatede signal in frequency domain
s_dem2=s_qam.*sin(2*pi*fc*t)*2 % i.e taking envelope when signal is positive and zero when signal is negative
S_dem2=fftshift(fft(s_dem2,Lfft)); % Demodulatede signal in frequency domain


% Using an ideal low pass filter with bandwidth 150 Hz
s_rec1=filter(h,1,s_dem1)
S_rec1=fftshift(fft(s_rec1,Lfft)); % Demodulatede signal in frequency domain
s_rec2=filter(h,1,s_dem2)
S_rec2=fftshift(fft(s_rec2,Lfft)); % Demodulatede signal in frequency domain
  


Trange1=[-0.025 0.025 -2 2] % axis ranges for signal 1, this specifies the range of axis for the plot, the first two parameters are range limits for x-axis, and last two parameters are for y-axis
Trange2=[-0.025 0.025 -2 4] %axis ranges for signal 2

Frange=[-700 700 0 250] % axis range for frequency domain plots

figure(1)
subplot(221); plot(t,m_sig1)
axis(Trange1) % set x-axis and y-axis limits 
title('m\_sig1')

subplot(222); plot(t,s_qam)
axis(Trange1)
title('s\_qam')

subplot(223); plot(t, s_dem1)
axis(Trange1) % set x-axis and y-axis limits 
title('s\_dem1')

subplot(224); plot(t,s_rec1)
axis(Trange1)
title('s\_rec1')


figure(2)
subplot(221); plot(t,m_sig2)
axis(Trange2) % set x-axis and y-axis limits 
title('m\_sig2')

subplot(222); plot(t,s_qam)
axis(Trange2)
title('s\_qam')

subplot(223); plot(t, s_dem2)
axis(Trange2) % set x-axis and y-axis limits 
title('s\_dem2')

subplot(224); plot(t,s_rec2)
axis(Trange2)
title('s\_rec2')




figure(3)
subplot(221); plot(freqm,abs(M1_sig))
axis(Frange) % set x-axis and y-axis limits 
title('M1\_sig')

subplot(222); plot(freqs,abs(S_qam))
axis(Frange)
title('S\_qam')

subplot(223); plot(freqs, abs(S_dem1))
axis(Frange) % set x-axis and y-axis limits 
title('S\_dem1')

subplot(224); plot(freqs,abs(S_rec1))
axis(Frange)
title('S\_rec1')


figure(4)
subplot(221); plot(freqm,abs(M2_sig))
axis(Frange) % set x-axis and y-axis limits 
title('M2\_sig')

subplot(222); plot(freqs,abs(S_qam))
axis(Frange)
title('S\_qam')

subplot(223); plot(freqs, abs(S_dem2))
axis(Frange) % set x-axis and y-axis limits 
title('S\_dem2')

subplot(224); plot(freqs,abs(S_rec2))
axis(Frange)
title('S\_rec2')




%%% Defining triangl function  used in above code
% triangl(t)=1-|t| , if |t|<1
% triangl(t)=0 , if |t|>1


function y = triangl(t)
y=(1-abs(t)).*(t>=-1).*(t<1); % i.e. setting y to 1 -|t|  if  |t|<1 and to 0 if not
%end

%%% example usage
% t=-5:.1:5
% y=triangl(t)
% stem(t,y)




%%% Define a triple sinc function to be used above, m=2sinc(2t/Ta)+sinc(2t/Ta-1)+sinc(2t/Ta+1)
%%% t is the length of the signal , Ta is the signal parameter, here equal
%%% to twice the delay

function m=triplesinc(t,Ta)
sig_1=sinc(2*t/Ta);  % signal 1
sig_2=sinc(2*t/Ta-1); % signal 2
sig_3=sinc(2*t/Ta+1); % signal 3

m=2*sig_1+sig_2+sig_3; % adding three signals as per our signal definition



%%% sample usage
% ts=10^(-4);
% t=-0.05:ts:0.05;
% Ta=0.01;
% m_sig=triplesinc(t,Ta)
% plot(t,m_sig) %%% plotting the signal 

