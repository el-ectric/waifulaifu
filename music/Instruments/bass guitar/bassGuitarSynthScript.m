%%%%%%%%%%%%%%%%%%%%%%%%%%{






%%%%%%%%%%%%%%%%%%%%%%%%%%}

fourierSeries = [9 4 2 13 2 2 3.5 2 1 0.5 2 1.5 0.5]; %Original Electric
fourierSeries = [9 9 9 8 8 8 8];
index = 1:length(fourierSeries)
%fourierSeries = fourierSeries.*exp(-index.*100);
fourierSeries = fourierSeries;
%fourierSeries = fourierSeriesSawtooth;
%fourierSeries = fourierSeries(1:3);
%chord = 2*[110 164.814];
%chord = [138.591 87.3071];
%chord = [chord 2.*chord];
%chord = [97.9989 73.4162];
chord = [369.994 293.665 220]*1.5; % D Major
%chord = [155.563 195.998 233.082 311.127];
%chord = [369.994 293.665];
%chord = 311.127/4;
%chord = [246.942 329.628] /2;
%chord = [659.255 830.609]/2;
soundLength = 15;


%Quintessential Quintuplets Bass Line
clear notes;
notes(1).pitch = 82.4069*ones(441000,1)/2;
notes(2).pitch = 82.4069*ones(441000,1)/2;
notes(3).pitch = 82.4069*ones(441000,1)/2;
notes(4).pitch = 82.4069*ones(441000,1)/2;
notes(5).pitch = 46.2493*ones(441000,1);

notes(6).pitch = 51.9130*ones(441000,1);
notes(7).pitch = 51.9130*ones(441000,1);
notes(8).pitch = 51.9130*ones(441000,1);
notes(9).pitch = 51.9130*ones(441000,1);


noteTimes = [0 1 2 2.5 3 3.5 4.5 5 6.5]/2.85;
noteDampingDelay = [0.5 1 0.5 0.5 0.5 0.5 1 1 0.5 ]/2.85;

tt = 1:(soundLength*44100);
d = zeros(1,length(tt));
noteLength = 10;
for noteIndex = 1:length(notes)
  if((noteTimes(noteIndex)*44100)+(44100*noteLength)>length(d))
    d((noteTimes(noteIndex)*44100):(length(d))) += ...
      bassGuitarSynth(notes(noteIndex).pitch, (noteLength-(length(d)/44100)-(noteTimes(noteIndex))), 0.2, fourierSeries, 10 ,noteDampingDelay(noteIndex));
  else
    d((1+(noteTimes(noteIndex)*44100)):((noteTimes(noteIndex)*44100)+(44100*noteLength))) += ...
     bassGuitarSynth(notes(noteIndex).pitch, noteLength, 0.2, fourierSeries, 10 ,noteDampingDelay(noteIndex));
  end
end

saveD = d;

sample = audioread("test.wav");
sample = sample(:,1);
%d = sample';

%Distortion
distortionFactor = 7;
d = 2./(1+exp(-(distortionFactor.*d)))-1;
d = applyHP(d);

% Low pass filter
d = applyLP(d,1200);

% Add some silence to beginning
d = [zeros(1,44100) d];

soundsc(d,44100);