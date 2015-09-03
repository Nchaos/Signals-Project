%%% Computing fourier coefficients using fft
function fourier_coeff

clear all
clf

T0=pi;
N0=64;
Ts=T0/N0;
M=10;

t=[0:Ts:Ts*(N0-1)]';
g=exp(-t/2);
g(1)=0.604;

Dn=1/N0*fft(g) % fft function in matlab calculates fourier coefficients using an algorithm called fft algorithm

[Dnangle,Dnmag]=cart2pol(real(Dn),imag(Dn)) % converting cartesian to polar coordinates using inbuilt matlab function cart2pol

k=0:length(Dn)-1

subplot(211), stem(k,Dnmag), title('Dnmag') % subplot(xyz), indicates create x times y subplots in a single plot, and position current plot in z location
subplot(212), stem(k,Dnangle), title('Dnangle') 


%%% Fourier coefficients can also be computed using numerical integration, 
%%% see page (77) in textbook for matlab code