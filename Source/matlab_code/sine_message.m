%This function generates a sine wave message that lasts for a variable
%amount of time, given by the user (specified in seconds) with output in
%miliseconds, frequency is specified in hertz
function [y t] = sine_message(frequency,max_time)
mult = 2 * pi * (1/frequency);
time = 0:0.01:(max_time)
y = sin(mult*time)
t=time
