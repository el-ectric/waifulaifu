pitches=    [0              97.9989*2     155.563*2     146.832*2     130.813*2     116.541*2     103.826*2     97.9989*2     155.563*2     174.614*2;
             65.4064/2        0           0           0           0           0           0         77.7817           0         87.3071;
             65.4064        0           0           0           0           0           0           77.7817/2           0           87.3071/2;
             65.4064/2        0           0           0           0           0           0         77.7817           0         87.3071;
             65.4064        0           0           0           0           0           0           77.7817/2           0           87.3071/2]*0.94;
times =     [0              5           6           7           8           14          15          16          22          24;
             0              5           6           7           8           14          15          16          22          24;
             0              5           6           7           8           14          15          16          22          24;
             0              5           6           7           8           14          15          16          22          24;
             0              5           6           7           8           14          15          16          22          24];
lengths =   [5              1.3           1.3           1.3           6.3           1.3           1.3           6           2           4;
             16             0           0           0           0           0           0           6           2           4;
             16             0           0           0           0           0           0           6           2           4;
             16             0           0           0           0           0           0           6           2           4;
             16             0           0           0           0           0           0           6           2           4];
             
             
volume =    [];
bpm = 190;

range= 0.01;
%range = 0;
instruments = 40;

seconds = 100;

tt = (0:(1/44100):seconds)';

left = zeros(length(tt),1);
right = left;


for a = 1:length(pitches(:))
for k = 1:instruments
   sectionIndices = (((times(a))/bpm*60)*44100):(((times(a)+lengths(a))/bpm*60)*44100);
   sectionIndices = round(sectionIndices);
   sectionIndices = sectionIndices + 1;
   left(sectionIndices) = left(sectionIndices) + sawtooth((2*pi*(pitches(a) - (0.5*range*pitches(a)) + (rand()*range*pitches(a))).*(sectionIndices./44100)) + (rand()*2*pi),0.85)';
   right(sectionIndices) = right(sectionIndices) + sawtooth((2*pi*(pitches(a) - (0.5*range*pitches(a)) + (rand()*range*pitches(a))).*(sectionIndices./44100)) + (rand()*2*pi),0.85)';
end
end

left = applyHP(left);
right = applyHP(right);

out = [left right];
out = out./max(out);
audiowrite("output.wav",out,44100);
soundsc(out,44100);