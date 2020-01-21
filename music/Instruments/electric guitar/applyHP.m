function[out] = applyHP(waveform, cutoffFreq)
cutoffFreq = 10;
pkg load signal;
[b,a] = cheby1(2, 5, 2*pi*cutoffFreq/44100, 'high');
out = filter(b,a,waveform);
end