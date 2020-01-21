function[fundFreqs fundMagnitudes harmonicMagnitudeArray] = findFundamental(inputWaveform, signalLength, overlap, FFTLength)

% fftlength of 4000 seems good
inputWaveform = inputWaveform - mean(inputWaveform);

increment = signalLength - overlap;

subplot(2,1,1);
plot(inputWaveform);

fundFreqs = [];
fundMagnitudes = [];

harmonicMagnitudeArray = []; %columns are harmonicMagnitude and rows are time
consonantWaveform = [];

%find fundamental 
for k = 1:increment:(length(inputWaveform)-signalLength)
  
  %{
  subplot(2,1,1);
  %plot(inputWaveform);
  hold on;
  plot([k (k+1)],[min(inputWaveform) max(inputWaveform)]);
  hold off;
  
  subplot(2,1,2);
  fourier = abs(fft(inputWaveform((k+1):(k+signalLength-1))))./fourier;

  plot(fourier(1:1000));
  axis([0 1000 0 300]);
  title(k/44100);
  pause(0.1);
  fflush(stdout);
  %}
  
  

  signalSegment = inputWaveform((k+1):(k+signalLength-1));
  %signalSegment = applyLP(signalSegment, 4000);
  %signalSegment = xcorr(signalSegment); % autocorrelation to make fundamental stronger
  signalSegmentRaw = signalSegment;
  autoCorr = xcorr(signalSegment);
  signalSegment = signalSegment.*hann(length(signalSegment)).*2;
  zeroPadding = FFTLength - length(signalSegment);
  
  signalSegment = [signalSegment; zeros(zeroPadding, 1)];
  
  fourier = abs(fft(signalSegment));
  
  fourier = fourier./signalLength;
  
  %{
  subplot(2,1,1);
  plot(fourier(1:5000));
  
  %axis([1 1500 0 250]);
  subplot(2,1,2);
  plot(autoCorr(4000:6000));
  %axis([1 10000 -1 1]);
  pause(0.1);
  fflush(stdout);
  %}
  
  upperFreqFund = 300;
  lowerFreqFund = 100;
  
  [fundFreq fundMagnitude] = findFirstPeak(fourier, 5, upperFreqFund, lowerFreqFund,44100);
  fundFreqs = [fundFreqs fundFreq];
  fundMagnitudes = [fundMagnitudes fundMagnitude];
  
  
  %find harmonic magnitudes
  harmonicMagnitudes = [];
  for harmonic = 1:20
    upperFreq = fundFreq + (harmonic*upperFreqFund) + (0.1*fundFreq);
    lowerFreq = fundFreq + (harmonic*upperFreqFund) - (0.1*fundFreq);
    [junk harmonicMagnitude] = findFirstPeak(fourier,lowerFreq, upperFreq,5 ,44100);
    harmonicMagnitudes = [harmonicMagnitudes harmonicMagnitude];
  end
  harmonicMagnitudeArray = [harmonicMagnitudeArray ; harmonicMagnitudes];
  
end

out = 1;
end