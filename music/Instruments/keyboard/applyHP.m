function[out] = applyHP(waveform)
cutoffFreq = 10;
[b,a] = cheby1(2, 5, cutoffFreq/44100, 'high');
out = filter(b,a,waveform);
end