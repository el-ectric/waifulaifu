% User specifies the rhythm of snare and kick using two vectors. Program 
% generates wav file.

% User inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
snareRhythm1 = [1 1 0 0 0 0 1 1 0 0 0 0 1 0 1 0];
kickRhythm1 =  [0 0 0 1 1 0 0 0 0 1 1 0 1 0 1 0];
hiHatRhythm1 =  [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
snareRhythm2 = [0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 1 1 1];
kickRhythm2 =  [1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0];
hiHatRhythm2 = [1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0];
bpm = 155.8*4;

for k = 1:3
    snareRhythm2 = [snareRhythm2 snareRhythm2];
    kickRhythm2 = [kickRhythm2 kickRhythm2];
    hiHatRhythm2 = [hiHatRhythm2 hiHatRhythm2];
end

snareRhythm = [snareRhythm1 snareRhythm2];
kickRhythm = [kickRhythm1 kickRhythm2];
hiHatRhythm = [hiHatRhythm1 hiHatRhythm2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}
bpm = 128*4;
snareRhythm =  [0 0 0 0 1 0 0 0];
kickRhythm =   [1 0 0 0 0 0 0 0];
hiHatRhythm =  [1 0 1 1 1 0 1 1];

for k = 1:7
    snareRhythm = [snareRhythm snareRhythm];
    kickRhythm = [kickRhythm kickRhythm];
    hiHatRhythm = [hiHatRhythm hiHatRhythm];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 44100;
secondsPerNote = (1/bpm).*60;

% load samples
snare = audioread('snareWithGatedReverb.wav');
kick = audioread('kickDrumSample.wav');
hiHat = audioread('hiHatSample.wav');

% normalize kick
kick = (1./max(abs(kick))).*kick;
snare = snare.*0.6;
hiHat = hiHat.*0.5;

snareIndices = find(snareRhythm);
kickIndices = find(kickRhythm);
hiHatIndices = find(hiHatRhythm);

waveform = zeros(ceil((fs*length(snareRhythm).*secondsPerNote) + 441000), 2);

startIndices = round(fs.*(snareIndices-1).*secondsPerNote)+1;
endIndices = startIndices + length(snare) -1;

for k = 1:length(snareIndices)
    waveform(startIndices(k):endIndices(k),:) = waveform(startIndices(k):endIndices(k),:) + snare;
end

startIndices = round(fs.*(kickIndices-1).*secondsPerNote)+1;
endIndices = startIndices + length(kick) -1;

for k = 1:length(kickIndices)
    waveform(startIndices(k):endIndices(k),:) = waveform(startIndices(k):endIndices(k),:) + kick;
end

startIndices = round(fs.*(hiHatIndices-1).*secondsPerNote)+1;
endIndices = startIndices + length(hiHat) -1;

for k = 1:length(hiHatIndices)
    waveform(startIndices(k):endIndices(k),:) = waveform(startIndices(k):endIndices(k),:) + 0.1*hiHat;
end

%soundsc([zeros(40000,2); waveform],44100);
waveform = waveform./max(abs(waveform));

audiowrite('output.wav', waveform, 44100);