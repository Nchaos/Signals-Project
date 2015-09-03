%% FFT of Signals in Matlab
% August 31, 2010
% Robert Francis
% rpf100020@utdallas.edu
%
%% Define time vector
samplingFrequency = 1000; %Hz
timeStep = 1/samplingFrequency; %sec
T = 1; %sec
S = T*samplingFrequency; %samples
samples = 1:S; %samples
time = samples*timeStep; %sec

%% Generate Sine wave
frequency1 = 5; %Hz
frequency2 = 7; %Hz
sineWave = sin(time*frequency1*2*pi)+sin(time*frequency2*2*pi); 
figure(1), plot(time,sineWave,'r')
xlabel('Time (sec)')
ylabel('Amplitude')
title(['Original Sinusoid with ' num2str(frequency1) 'Hz and ' num2str(frequency2) 'Hz'])
set(gca,'YLim',[-2.1 2.1])

%% Fast Fourier Transform of Sine Wave
L = length(sineWave);
NFFT = 2^nextpow2(L); % Next power of 2 from length of signal
FsineWave = fft(sineWave,NFFT)/L;
f = samplingFrequency/2*linspace(0,1,NFFT/2+1);

%% Plot single-sided amplitude spectrum.
figure, plot(f,2*abs(FsineWave(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of SineWave')
xlabel('Frequency (Hz)')
ylabel('|SineWave(f)|')

%% Generate square wave
pulseFrequency = 8; %Hz
squareWave = square(time*pulseFrequency*2*pi); 
squareWavePos = (squareWave+1)/2;
figure, plot(time,squareWavePos,'r')
set(gca,'YLim',[-0.1 1.1])

%% Fast Fourier Transform of Square Wave
L = length(squareWave);
NFFT = 2^nextpow2(L); % Next power of 2 from length of signal
FsqWave = fft(squareWave,NFFT)/L;
f = samplingFrequency/2*linspace(0,1,NFFT/2+1);

%% Plot single-sided amplitude spectrum.
figure, plot(f,2*abs(FsqWave(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of SquareWave')
xlabel('Frequency (Hz)')
ylabel('|SquareWave(f)|')

%% Plot Single-sided Phase Plots
figure, plot(f,phase(FsqWave(1:NFFT/2+1))) 
title('Single-Sided Phase Spectrum of SquareWave')
xlabel('Frequency (Hz)')
ylabel('Phase(Y(f))')

%% Plot Amplitude and Phase in Same figure
figure, 
subplot(2,1,1), plot(f,2*abs(FsqWave(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of SquareWave')
xlabel('Frequency (Hz)')
ylabel('|SquareWave(f)|')
subplot(2,1,2), plot(f,phase(FsqWave(1:NFFT/2+1))) 
title('Single-Sided Phase Spectrum of SquareWave')
xlabel('Frequency (Hz)')
ylabel('Phase(SquareWave(f))')
%% Decibels
magnitude = 2*abs(FsqWave(1:NFFT/2+1));
dbs = 20*log10(magnitude);
dbs_anotherWay = mag2db(magnitude);
dbs_yetAnotherWay = pow2db(magnitude); %Note: 10*log10(magnitude)
figure, 
subplot(2,1,1), plot(f,dbs) 
title('Single-Sided Amplitude Spectrum of SquareWave')
xlabel('Frequency (Hz)')
ylabel('|SquareWave(f)| (db)')
subplot(2,1,2), plot(f,phase(FsqWave(1:NFFT/2+1))) 
title('Single-Sided Phase Spectrum of SquareWave')
xlabel('Frequency (Hz)')
ylabel('Phase(Y(f))')

%% Add noise to squareWave
noisySqW = squareWavePos + 3*randn(size(squareWavePos));
figure, plot(time,noisySqW), xlabel('Time (sec)'), ylabel('Amplitude')

%% Fourier Transform of noisySqW
L = length(noisySqW);
NFFT = 2^nextpow2(L); % Next power of 2 from length of signal
FnsqWave = fft(noisySqW,NFFT)/L;
f = samplingFrequency/2*linspace(0,1,NFFT/2+1);

%% Plot noisy Fourier Transform
figure, 
subplot(2,1,1), plot(f,2*abs(FnsqWave(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of SquareWave')
xlabel('Frequency (Hz)')
ylabel('|SquareWave(f)|')
subplot(2,1,2), plot(f,phase(FnsqWave(1:NFFT/2+1))) 
title('Single-Sided Phase Spectrum of SquareWave')
xlabel('Frequency (Hz)')
ylabel('Phase(Y(f))')

%% Fourier Transform of an Impulse
impulse = [0 0 0 0 0 1 0 0 0 0 0];
L = length(impulse);
NFFT = 2^nextpow2(L); % Next power of 2 from length of signal
Fimpulse = fft(impulse,NFFT)/L;

figure, plot(abs(Fimpulse))

%% Fourier Transform of a DC Signal
DC = ones(1,1000);
L = length(DC);
NFFT = 2^nextpow2(L); % Next power of 2 from length of signal
FDC = fft(DC,NFFT)/L;
DC2 = ones(1,100000);
L2 = length(DC2);
NFFT2 = 2^nextpow2(L2); % Next power of 2 from length of signal
FDC2 = fft(DC2,NFFT2)/L2;
% Arbitrary frequency vectors
f1 = linspace(0,1,length(FDC));
f2 = linspace(0,1,length(FDC2));
figure, plot(f1,abs(FDC),'b'), hold on, plot(f2,abs(FDC2),'r')
