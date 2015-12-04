[m, Fs] = audioread('test file for signals.wav');
ts = 1/Fs; %generate the time vector from the sampling rate Fs
m = m(:,1); %assign the m vector to variable m 
m = m'; %Taking the transpose of m

[m2, Fs2] = audioread('voice2.wav');
ts2 = 1/Fs2;
m2 = m2(:,1);
m2 = m2';

Length = length(m);
Length2 = length(m2);
t = (0:Length-1)/Fs;
t2 = (0:Length2-1)/Fs2;

M = fftshift(fft(m, Length));
M_sig = abs(M);
freqm = (-Length/2 : Length/2 -1)/(Length/ts);

M2 = fftshift(fft(m2, Length2));
M2_sig = abs(M2);
freqm2 = (-Length2/2 : Length2/2 -1)/(Length2/ts2);

figure, plot(freqm,M_sig) 
title('Nick''s Voice Message - Frequency')
xlabel('Frequency (Hz)');
ylabel('Amplitude');

figure, plot(freqm2,M2_sig) 
title('Andy''s Voice Message - Frequency')
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%{
figure, plot(t,m) 
title('Nick''s Voice Message')
xlabel('Time (s)');
ylabel('Amplitude');

figure, plot(t2,m2) 
title('Andy''s Voice Message')
xlabel('Time (s)');
ylabel('Amplitude');
%}