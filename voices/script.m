%pkg load signal;

sample = audioread("yukirinu sample.wav");
sample = sample(:,1);
fs = 44100;
[fundFreqs fundMagnitudes harmonicMagnitudeArray] = findFundamental(sample,4000,0,44100);

fundamentalOutput = synthesizeFromPitch(fundFreqs, fundMagnitudes, 4000, 44100);

totalOutput = fundamentalOutput;

for k = 1:20
  harmonicWaveform = synthesizeFromPitch((fundFreqs.*k), harmonicMagnitudeArray(:,k), 4000, 44100);
  totalOutput = totalOutput + harmonicWaveform;
end

disp("playing"); %fflush(stdout);

%{
totalOutput = [zeros(44100*5,1); totalOutput'];
soundsc(totalOutput,44100);
%}

% adjust voice
%outputWaveform = zeros(length(sample),1);
outputWaveform = [];
increment = 4000;
numHarmonics = 20;
fourierCoeffRatios = 1.*ones(1,20);
index = 1;
for k = 1:length(fundFreqs)
  segment = sample((1+((k-1)*increment)):((k*increment)-1));
  segment = multipleBandpass(segment, fundFreqs(k), numHarmonics, fourierCoeffRatios,fs);
  %outputWaveform(index:(index+increment-1)) = segment;
  %index = index + increment;
  outputWaveform = [outputWaveform; segment];
  disp(k); pause(0.001);%fflush(stdout);
end

soundsc(outputWaveform,44100);