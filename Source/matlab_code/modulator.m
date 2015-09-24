function [  ] = modulator( f0,fs,fc )
%modulator Summary of this function goes here
%   Detailed explanation goes here
%   f0 frequency 
%   fs frequency sampling
%   yt signal (voice)
%   fc frequncy carrier
%   yc carrier signal

fSampling = fs;
tSampling = 1/fSampling;
t = -0.005:tSampling:0.005;


yt = sin(2*pi*f0*t);

y= yt.*cos(2*pi*fc*t);

mody_fft = fft(y);
n = numel(mody_fft); 
f = 0:fSampling/n:fSampling*(n-1)/n;

y2 = y.*cos(2*pi*fc*t);
mody2_fft = fft(y2);
n2 = numel(mody2_fft);
f2 = 0:fSampling/n2:fSampling*(n2-1)/n2;
plot(f2, abs(mody2_fft))

end

