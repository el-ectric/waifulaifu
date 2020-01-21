%%%%%%%%%%%%%%%%%%%%%%%%%%{






%%%%%%%%%%%%%%%%%%%%%%%%%%}

fourierSeries = [9 4 2 13 2 2 3.5 2 1 0.5 2 1.5 0.5];
index = 1:length(fourierSeries)
%fourierSeries = fourierSeries.*exp(-index.*100);
%fourierSeries = fourierSeries(1:2);
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

%d = zeros(1,(toneLength*44100));

%{
notes = [369.994 293.665 220];
notes = [293.665  329.628 369.994 391.995 440 493.883 554.365 587.330];
noteTimes = [0.5 1 1.5 2 2.5 3 3.5 4]/2;
noteDampingDelay = [0.501 0.501 0.501 0.501 0.51 0.51 0.51 5000 ]/2;
%}

%notes = [369.994 293.665 220];
noteTimes = [0 0 0];
noteDampingDelay = [1 1 1];

%{
% ZARD BEGINNING

% pitches
notes(1).pitch = (415.305-25).*ones(44100*10,1)+(25./(1+exp(-20*(((1:441000)./44100)-.5))))';
notes(2).pitch = 391.995.*ones(441000,1);
notes(3).pitch = 415.305.*ones(441000,1);
notes(4).pitch = 261.626.*ones(441000,1);
notes(5).pitch = 277.183.*ones(441000,1);
notes(5).pitch = (277.183.*ones(441000,1))+(10*cos(8.*pi.*((1:441000)./44100))./(1+exp(-2.*(((1:441000)./44100)-1))))';

noteTimes = [

  0
  4 
  5 
  7 
  9
  
  ]/3.67;
noteDampingDelay = [4 1 2 2 8]/3.67;

%}

%{
% ZARD BEGINNING EXPRESSIVE
notes(1).pitch = 523.251*ones(441000,1);
notes(1).pitch = notes(1).pitch - ((15+15.*cos(2*pi*3.*((1:441000)./44100)))./(1+exp(30.*(((1:441000)./44100)-0.3))))';
noteTimes = 0;
noteDampingDelay = 7;
% END ZARD BEGINNING EXPRESSIVE

%}

%{
clear notes;
notes(1).pitch = 82.4069*ones(441000,1);
notes(2).pitch = notes(1).pitch/2;
noteTimes = [1 1];
noteDampingDelay = [50 50];
%}

% chord
clear notes
notes(1).pitch = 587.330*ones(441000,1);
notes(2).pitch = 440*ones(441000,1);
notes(3).pitch = 369.994*ones(441000,1);
notes(4).pitch = 293.665*ones(441000,1);

noteTimes = [0.4 .3 .2 0.1]/3;
noteDampingDelay = [9 9 9 9];

tt = 1:(soundLength*44100);
d = zeros(1,length(tt));
noteLength = 10;
for noteIndex = 1:length(notes)
  if((noteTimes(noteIndex)*44100)+(44100*noteLength)>length(d))
    d((noteTimes(noteIndex)*44100):(length(d))) += ...
      guitarSynth(notes(noteIndex).pitch, (noteLength-(length(d)/44100)-(noteTimes(noteIndex))), 0.5, fourierSeries, 10 ,noteDampingDelay(noteIndex));
  else
    d((1+(noteTimes(noteIndex)*44100)):((noteTimes(noteIndex)*44100)+(44100*noteLength))) += ...
     guitarSynth(notes(noteIndex).pitch, noteLength, 0.5, fourierSeries, 10 ,noteDampingDelay(noteIndex));
  end
end

saveD = d;

sample = audioread("test.wav");
sample = sample(:,1);
%d = sample';

%Distortion
distortionFactor = 50;
d = 2./(1+exp(-(distortionFactor.*d)))-1;
d = applyHP(d);

% Low pass filter
d = applyLP(d,1200);

% Add some silence to beginning
d = [zeros(1,44100) d];

soundsc(d,44100);