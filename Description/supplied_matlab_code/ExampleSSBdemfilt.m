%%% Illustrate SSB modulation  using triangl function
%%% Defining message signal as a triangle signal, in real life however, this
%%% could be anything like voice signal etc. that we would want to transmit
function ExampleSSBdemfilt

clear all;
clf;

ts=10^(-4);
t=-0.04:ts:0.04;
Ta=0.01;
m_sig=triangl((t+0.01)/0.01)-triangl((t-0.01)/0.01);
Lm_sig=length(m_sig);
Lfft=length(t);   % defining DFT (or FFT) size
Lfft=2^ceil(log2(Lfft))  % making Lfft a power of 2 since this makes the fft algorithm work fast
M_sig=fftshift(fft(m_sig,Lfft))  % i.e. calculating the frequency domain message signal,
                                 % fft algorithm calculates points from ) to Lfft-1, hence we use fftshift on this
                                 % result to order samples from -Lfft/2 to Lfft/2 -1 
freqm=(-Lfft/2:Lfft/2-1)/(Lfft*ts) % Defining the frequency axis for the frequency domain DSB modulated signal
B_m=150;
h=fir1(40,[B_m*ts]) % defining a FIR filter of order 40 and cutoff frequency B_m*ts

%%% SSB modulation
fc=300; % carrier frequency
s_dsb=(m_sig).*cos(2*pi*fc*t) 
Lfft=length(t);   % defining DFT (or FFT) size
Lfft=2^ceil(log2(Lfft)+1)  % increasing Lfft by factor of 2 
S_dsb=fftshift(fft(s_dsb,Lfft)); % obtaining frequency domain modulated signal
L_lsb=floor(fc*ts*Lfft)
SSBfilt=ones(1,Lfft); % i.e. defining the filter to filter out LSB component from DSB signal
SSBfilt(Lfft/2-L_lsb+1:Lfft/2+L_lsb)=zeros(1,2*L_lsb); % i.e. defining the filter to filter out LSB component from DSB signal
S_ssb=S_dsb.*SSBfilt;
freqs=(-Lfft/2:Lfft/2-1)/(Lfft*ts) % Defining the frequency axis for the frequency domain DSB modulated signal
s_ssb=real(ifft(fftshift(S_ssb)));
s_ssb=s_ssb(1:Lm_sig);


%%% Demodulation begins by using a rectifier 
s_dem=s_ssb.*cos(2*pi*fc*t)*2 % i.e taking envelope when signal is positive and zero when signal is negative
S_dem=fftshift(fft(s_dem,Lfft)); % Demodulatede signal in frequency domain

% Using an ideal low pass filter with bandwidth 150 Hz
s_rec=filter(h,1,s_dem)
S_rec=fftshift(fft(s_rec,Lfft)); % Demodulatede signal in frequency domain
 


Trange=[-0.025 0.025 -1 1] % This specifies the range of axis for the plot, the first two parameters are range limits for x-axis, and last two parameters are for y-axis
Frange=[-700 700 0 200] % axis range for frequency domain plots
figure(1)
subplot(221); plot(t,m_sig)
axis(Trange) % set x-axis and y-axis limits 
title('m\_sig')

subplot(222); plot(t,s_ssb)
axis(Trange)
title('s\_ssb')

subplot(223); plot(t, s_dem)
axis(Trange) % set x-axis and y-axis limits 
title('s\_dem')

subplot(224); plot(t,s_rec)
axis(Trange)
title('s\_rec')


figure(2)
subplot(221); plot(freqm,abs(M_sig))
axis(Frange) % set x-axis and y-axis limits 
title('M\_sig')

subplot(222); plot(freqs,abs(S_ssb))
axis(Frange)
title('S\_ssb')

subplot(223); plot(freqs, abs(S_dem))
axis(Frange) % set x-axis and y-axis limits 
title('S\_dem')

subplot(224); plot(freqs,abs(S_rec))
axis(Frange)
title('S\_rec')


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
