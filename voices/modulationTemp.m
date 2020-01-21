sample = audioread("yukirinu sample.wav");
sample = sample(:,1);

origLength = length(sample);

b = fir2(4000,[0 0.16 0.16 1], [1 1 0 0]);
sample = conv(b,sample);
sample = sample(1:origLength);

subplot(3,2,1);
plot(abs(fft(sample)));

cosineMod = cos((1:length(sample))*0.5*pi);

sampleMod = cosineMod.*sample';
subplot(3,2,2);
plot(abs(fft(sampleMod)));

b = fir2(4000, [0 0.5 0.5 1], [1 1 0 0]);
sampleMod = conv(sampleMod, b);
sampleMod = sampleMod(1:length(sample));
subplot(3,2,3);
plot(abs(fft(sampleMod)));


cosineMod = cos((1:length(sample))*(0.504)*pi);
sampleMod = cosineMod.*sampleMod;
subplot(3,2,4);
plot(abs(fft(sampleMod)));

%{
b = fir2(4000, [0 0.369 0.369 1], [1 1 0 0]);

subplot(3,2,5);
sampleMod = conv(sampleMod,b);
plot(abs(fft(sampleMod)))
%}

soundsc(sampleMod,44100)
