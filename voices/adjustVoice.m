function[outputWaveform] = adjustVoice(sample, increment, fs, fundFreqs, fundMagnitudes, harmonicMagnitudeArray, fourierCoeffRatios)

outputWaveform = [];
for k = 1:increment:(length(inputWaveform)-signalLength)
  segment = sample(k:(k+increment));
  segment = multipleBandpass(input, fundamentalFreq, numHarmonics, fourierCoeffRatios);
  outputWaveform = [outputWaveform segment];
end

end