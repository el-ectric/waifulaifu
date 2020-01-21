function[out] = guitarSynth(fundamentalFreq, toneLength, decayFactor, ...
  fourierSeries,dampingFactor,dampingDelay)

fs = 44100;
%fundamentalFreq = 110;
tt = 1:(toneLength*fs);
% sum fourier series
y = zeros(1,length(tt));
for k = 1:length(fourierSeries)
  %{
  fc = fundamentalFreq.*k;
  modFreqAmp = 0.2;
  modFreq = 4;
  
  freq = 2*pi*(fc.*tt/fs);
  
  carrierFreqPhase = 2*pi*fc.*tt/fs;
  
  modulationFreqPhase = 2*pi*modFreqAmp.*(-cos(2*pi*modFreq.*tt/fs));
  modulationFreqPhase = modulationFreqPhase./(1+exp(-(tt-22000)));
  
  
  
  phase = carrierFreqPhase+modulationFreqPhase;
  %}
 
  
  phase = 2*pi*cumtrapz(tt/44100, (fundamentalFreq.*k)');
  
  sinusoid = fourierSeries(k).*cos((rand*2*pi)+phase);


  %Decay  
  freqDecayFactor = decayFactor.*(k^1);
  sinusoid = sinusoid .* exp(-tt.*freqDecayFactor./fs);
  sinusoid = sinusoid .* (1-exp(-(100*tt/fs))); % start
  
  %Damping
  freqDampingFactor = dampingFactor*(k^3);
  sinusoid = sinusoid .*((-1./(1+exp(-(freqDampingFactor.*((tt./fs)-(dampingDelay))))))+1);
 
  
  %High Pass Filter
  sinusoid = applyHP(sinusoid);
  
  %add space at beginning 
  sinusoid = [zeros(1,4215) sinusoid];
  %remove from end
  sinusoid = sinusoid(1:(length(sinusoid)-4215));
  
  y += sinusoid;
  y = y + sinusoid;

end

%Add pluck
pluck = audioread("pluck.wav");
pluck = pluck(:,1)';

y = 2*(y-min(y))./(max(y)-min(y))-1;
y = applyHP(y);
y(1:length(pluck)) = 0.2*pluck + y(1:length(pluck));
out = y;
end