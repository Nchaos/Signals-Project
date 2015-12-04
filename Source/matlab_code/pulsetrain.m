delay_random = random('Normal',0,10,1,1)* 2; % Delay randomly generated
freq_random = random('Normal',0,10,1,1)*100; % Frequency randomly generated
phase_random = random('Normal',0,10,1,1)*100; %Phase randomly generated
time = 0:1/50:10 ; %Time from 0 to 10 seconds 
pulse_time = 0:1/50:0.5; %Pulse duration from 0 to 0.5 seconds
a=0;
p = 0;
signal  = zeros(1,length(0:1/50:delay_random));
while(p <=10)
    a = sin(2*pi*freq_random*(0:1/50:0.5) + phase_random);
    p=p+0.5;
    signal = cat(signal,a);
end
figure(1);
plot(time,a);