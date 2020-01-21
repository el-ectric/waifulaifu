function[out] = applyLP(waveform, cutoffFreq)
[b,a] = cheby1(2, 5, cutoffFreq/44100);
out = filter(b,a,waveform);
end