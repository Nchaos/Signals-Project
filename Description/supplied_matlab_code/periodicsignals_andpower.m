%%% periodic signals and signal power

function periodicsignals_andpower
clear all
clf

Dt=0.002 % time interval
T=6; % time period 
M=3; % to generate 2M periods of the signal
t=0:Dt:T-Dt % time for one period

%%% evaluate one period of signal
y=exp(-abs(t)/2).* sin(2*pi*t).* (ustep(t)-ustep(t-4));

%%% plot original signal
plot(t,y)

%%% generate the periodic signal
time=[];
y_periodic=[];

for i=-M:M-1 % i.e. 2M periods of the signal
    time=[time i*T+t] % i.e. generating time for each periodic interval
    y_periodic=[y_periodic y]; % i.e. generating periodic signal
end

%%% plot the periodic signal
plot(time,y_periodic)

%%% power calculation of periodic signal
y_power = (y_periodic*y_periodic')*Dt/(max(time)-min(time)) % i.e using relation between integral and summation for the power calculation 
% for any vector r, r' calculates hermitian (i.e. conjugate and transpose) of r, while r.' calculates transpose of r;
% for any row vector r, r*r' is same as r.*conj(r) , i.e. element wise
% multiplication of r and conj(r) and take sum of all resulting elements

                                                           

%%% energy calculation of original signal or in one period of the periodic signal
y_energy = (y*y')*Dt   % again, using integral and summation relation




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
