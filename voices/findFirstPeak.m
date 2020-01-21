function[peakFreq, peakMagnitude] = findFirstPeak(fourier, lowerFreq, upperFreq, threshold, fs)

stop = 0;

k = 1;

lowerIndex = round(length(fourier)*lowerFreq/fs);
upperIndex = round(length(fourier)*upperFreq/fs);

fourierLength = length(fourier);
fourier = fourier(lowerIndex: upperIndex);

[peakMagnitude peakIndex] = max(fourier);

peakIndex = peakIndex + lowerIndex;

peakFreq = fs*peakIndex/fourierLength;

end