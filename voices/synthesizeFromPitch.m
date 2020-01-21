function[outputWaveform] = synthesizeFromPitch(peakFreqs, peakMagnitudes, intervalLength,fs)

outputWaveform = [];
tt = 1:intervalLength;

phase = 0;

for k = 1:length(peakFreqs)
  segment = peakMagnitudes(k).*cos((2*pi*peakFreqs(k).*tt./fs)+phase);
  phase = 2*pi*peakFreqs(k).*tt(length(tt))./fs + phase;
  outputWaveform = [outputWaveform segment];
end

end