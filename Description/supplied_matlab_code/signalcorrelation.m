%%% calculate  correlation between any two signals

function signalcorrelation
clear all

Dt=0.01; % time increments
T=6; % ending time

t= -1:Dt:T   % t goes from -1 to T in Dt increments

%%% Define three signals that we shall calculate correlation
x=ustep(t)-ustep(t-5); % difference of two differently delayed unit step functions
g1=-(ustep(t)-ustep(t-5)) % negative version of the signal x signal defined before
g2=exp(-t/5).*(ustep(t)-ustep(t-5)); % another function using exponential and unit step function


%%% Compute signal energies

E0= sum(x.*conj(x))*Dt % energy of x(t); Using summation approximation to integral
E1= sum(g1.*conj(g1))*Dt % energy of g1(t); Using summation approximation to integral
E2=sum(g2.*conj(g2))*Dt % energy of g2(t); Using summation approximation to integral


%%% Compute correlation between x(t) with each of x(t), g1(t), g2(t)

c0=sum(x.*conj(x))*Dt/(sqrt(E0*E0))   % correlation between x and x
c1=sum(x.*conj(g1))*Dt/(sqrt(E0*E1))   % correlation between x and g1
c2=sum(x.*conj(g2))*Dt/(sqrt(E0*E2))   % correlation between x and g2


%%% unit step function, 
% y=ustep(t) = 1 ; t>=0 
% y=ustep(t) = 0 ; t<0 
% t can be matrix or scalar


function y=ustep(t)
y=(t>=0) % (t>=0) returns 1 (true) if t>=0, elase returns a 0 (false)



%%%%%%% Can plot the unit step function as follows:
% t= -5:0.1:5     % generates numbers from -5 to 5 in increments of 0.1
% y=ustep(t)
% plot(t,y)