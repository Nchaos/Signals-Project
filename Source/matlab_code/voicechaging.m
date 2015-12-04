[m, Fs] = audioread('test file for signals.wav');
ts = 1/Fs;
m = m(:,1);
m = m';

inFs = Fs;
outFs = 8000;
bw =7200;
SRC = dsp.SampleRateConverter('Bandwidth',bw,'InputSampleRate',inFs,...
                              'OutputSampleRate',outFs);

Length = length(m); % get the length of the voice message
t = (0 : Length - 1)/35000;
%figure, plot(t,m) 
t = (0 : Length - 1)/65000;
%figure, plot(t,m) 
%audiowrite('NickVoice_SamplingChangeSlow.wav', m, 35000);
%audiowrite('NickVoice_SamplingChangeFast.wav', m, 65000);