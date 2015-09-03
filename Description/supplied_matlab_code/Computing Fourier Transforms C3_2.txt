% C3_2.m
% Computer example C3.2
% computing Fourier Transforms
% use DFT to compute the Fourier transform of gk.
% Plot the resulting Fourier spectra.

clear all; close all; 
clc;
B=4;f0=1/4;
Ts=1/(2*B);
T0=1/f0;
N0=T0/Ts;
k=0:N0-1;k=k';
for m=1:length(k)
    if k(m)>=0 && k(m)<=3
        gk(m)=1;
    end
    
    if k(m)==4 || k(m)==28
        gk(m)=0.5;
    end

    if k(m)>=5 && k(m)<=27
        gk(m)=0;
    end
    
    if k(m)>=29 && k(m)<=31
        gk(m)=1;
    end
end
gk=gk';
Gq=fft(gk);
subplot(211),stem(k,gk);
subplot(212),stem(k,Gq);