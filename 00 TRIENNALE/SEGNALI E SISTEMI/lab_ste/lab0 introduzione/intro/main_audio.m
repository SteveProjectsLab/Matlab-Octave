clear
close all
clc

% Singola nota
samplefreq = 4000;
duration = 4;
t = linspace(0, duration, duration*samplefreq);
frequency = 440;
x = sin(frequency * 2*pi * t);
spectrogram(x,[],[],[],samplefreq,'yaxis')
% axis([0.2 duration-0.2 0 1])
sound(x,samplefreq)

% Scala
close all
duration = 2;
t = linspace(0, duration, duration*samplefreq);
scale = 2.^((0:12)/12);
sevenscale = [scale(1), scale(3), scale(5), scale(6), scale(8), scale(10), scale(12), scale(13)];
for k = 1:8
    x = sin(440*sevenscale(k) * 2*pi * t);
    spectrogram(x,[],[],[],samplefreq,'yaxis')
%     axis([0.1 1.9 0 1])
    sound(x,samplefreq)
    pause(duration)
end

% Chirp
close all
samplefreq = 1000;
duration = 8;
t = linspace(0, duration, duration*samplefreq);
x=chirp(t,0,1,150);
spectrogram(x,256,250,256,1E3,'yaxis')
sound(x,samplefreq)

% Balena
close all
[x,fs] = audioread('nepblue24s10x.wav');
spectrogram(x,100,[],[],fs,'yaxis')
sound(x,fs)
% axis([0.2 25 0 0.6])