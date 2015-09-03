% C3_1.m
% Computer example C3.1
% computing Fourier Transforms
% use DFT to compute the Fourier transform of exp(-2*t)*u(t).
% Plot the resulting Fourier spectra

clear all; close all; 
clc;
Ts=1/64;T0=4;N0=T0/Ts;
t=0:Ts:Ts*(N0-1);t=t';
g=Ts*exp(-2*t);
g(1)=Ts*0.5;
G=fft(g);
[Gp,Gm]=cart2pol(real(G),imag(G));
k=0:N0-1;k=k';
w=2*pi*k/T0;
subplot(211),stem(w(1:32),Gm(1:32));
subplot(212),stem(w(1:32),Gp(1:32));
