function[out] = applyLP(waveform, cutoffFreq)
cutoffFreq = 1500;
pkg load signal;
[b,a] = cheby1(2, 5, 2*pi*cutoffFreq/44100);
out = filter(b,a,waveform);
end