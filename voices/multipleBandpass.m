function[output] = multipleBandpass(input, fundamentalFreq, numHarmonics, fourierCoeffRatios,fs)
  halfBandwidth = 10; %Hz
  bandWidth = 2*halfBandwidth;
  
  
  % filter via convolution
  %{
  output = input;
  filterCoefficients = []; %each row is a frequency
  for k = 1:numHarmonics
    [b a] = butter(1, [((fundamentalFreq*k*2*pi)- halfBandwidth) ((fundamentalFreq*k*2*pi)+ halfBandwidth)]/fs);
    output = output + ((fourierCoeffRatios(k)-1).*filter(b,a,input));
  end
  %}

  % filter via fft
  fourier = fft(input);

  fundamentalIndex = round(length(fourier)*fundamentalFreq./fs);
  halfBandwidthIndex = ceil(length(fourier)*halfBandwidth./fs);
  
  freqDomainFilter = ones(1,length(input));
  hannLength = length((fundamentalIndex-halfBandwidthIndex):(fundamentalIndex+halfBandwidthIndex));
  
  if (fundamentalIndex-halfBandwidthIndex) > 0
    freqDomainFilter((fundamentalIndex-halfBandwidthIndex):(fundamentalIndex+halfBandwidthIndex)) = (fourierCoeffRatios(1))*(hann(hannLength));
    for k = 2:numHarmonics
      %generate hann window
      harmonicIndex = round(length(fourier)*k*fundamentalFreq./fs);
      freqDomainFilter((harmonicIndex-halfBandwidthIndex):(harmonicIndex+halfBandwidthIndex)) = (fourierCoeffRatios(k))*(hann(hannLength));
    end
  else
    
  end
  
  output = abs(ifft(freqDomainFilter'.*fourier));
end