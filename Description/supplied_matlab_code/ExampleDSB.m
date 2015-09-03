%%% Illustrate DSB modulation  using triple sinc

%%% Defining message signal as a triple sinc signal, in real life however, this
%%% could be anything like voice signal etc. that we would want to transmit
function ExampleDSB
clear all;
clf;

ts=10^(-4);
t=-0.05:ts:0.05;
Ta=0.01;
m_sig=triplesinc(t,Ta)

Lfft=length(t);   % defining DFT (or FFT) size
Lfft=2^ceil(log2(Lfft))  % making Lfft a power of 2 since this makes the fft algorithm work fast
freqm=(-Lfft/2:Lfft/2-1)/(Lfft*ts) % Defining the frequency axis for the frequency domain DSB modulated signal
M_sig=fftshift(fft(m_sig,Lfft))  % i.e. calculating the frequency domain message signal,
                                 % fft algorithm calculates points from ) to Lfft-1, hence we use fftshift on this
                                 % result to order samples from -Lfft/2 to Lfft/2 -1 
%%% DSB modulation
s_dsb=m_sig.*cos(2*pi*500*t) % recall DS modulation works by multiplying message signal by a cos function at the carrier frequency
Lfft=length(t)
Lfft=2^ceil(log2(Lfft)+1) % increasing fft size by another factor of 2
S_dsb=fftshift(fft(s_dsb,Lfft)); % obtaining frequency domain modulated signal
freqs=(-Lfft/2:Lfft/2-1)/(Lfft*ts) % Defining the frequency axis for the frequency domain DSB modulated signal

Trange=[-0.03 0.03 -2 2];
Frange=[-700 700 0 200];
subplot(221), plot(t,m_sig)
title('m\_sig')
axis(Trange)

subplot(222), plot(freqm,M_sig)
title('M\_sig')
axis(Frange)

subplot(223), plot(t,s_dsb)
title('s\_dsb')
axis(Trange)

subplot(224), plot(freqs,S_dsb)
title('S\_dsb')
axis(Frange)




%%% Define a triple sinc function, m=2sinc(2t/Ta)+sinc(2t/Ta-1)+sinc(2t/Ta+1)
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

