%%%%%%
%sawtooth
%%%%%%
dutyCycle = 0.4;
freq = 180;
fs = 44100;

period = 1/freq;
period *= fs;

t1 = 1:(period.*dutyCycle);
y1 = t1.*(2/length(t1))-1;
plot(y1);

t2 = 1:(period.*(1-dutyCycle));
y2 = -t2.*(2/length(t2))+1;
plot(y2);

toneLength = 5;
y3 = [];

for cycleNo = 1:(5*freq)
  y3 = [y3 y1 y2];
  
endfor
plot(y3)

soundsc(y3,44100);