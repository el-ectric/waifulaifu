
%notes = [;
pitches = [277.183 349.228 415.305];
pitches = 277.183*1;

tt = 0:(1/44100):4;
out = zeros(1,length(tt));
out1 = out;
out2 = out;

envelope1 = (1-exp(-tt.*600)).*9.*exp(-tt.*1);
envelope2 = (1-exp(-tt.*600)).*9.*exp(-tt.*20);

%[rows columns] = size(notes);

for k = 1:length(pitches)
    shift = 2*pi*rand();
    carrier1 = cos(2*pi*pitches(k).*tt+(rand().*2*pi));
    mod11 = cos(2*pi*pitches(k)*1.*tt);
    mod12 = cos(2*pi*pitches(k)*3.*tt);
    
    carrier2 = cos(2*pi*pitches(k).*tt+(rand().*2*pi));
    mod2 = cos(2*pi*pitches(k).*20.*tt);
    
    out1 = out1 + (carrier1);
    out2 = out2 + (carrier2.*mod2);
end

out1 = out1.*envelope1;
out2 = 1*out2.*envelope2;

out = out1+out2;
left = out;
for k = 1:length(pitches)
    shift = 2*pi*rand();
    carrier1 = cos(2*pi*pitches(k).*tt+shift);
    mod11 = 3*cos(2*pi*pitches(k)*5.*tt+shift);
    mod12 = 2*sawtooth(2*pi*pitches(k)*1.*tt+shift);
    mod13 = 2*cos(2*pi*pitches(k)*2.*tt+shift);
    
    carrier2 = cos(2*pi*pitches(k).*tt+(rand().*2*pi));
    mod2 = cos(2*pi*pitches(k).*20.*tt);
    
    out1 = out1 + (carrier1.*mod11.*mod12.*mod13);
    out2 = out2 + (carrier2.*mod2);
end

out1 = out1.*envelope1;
out2 = 1*out2.*envelope2;

out = out1+out2;
%out = right;
%out = [left; right];
plot(abs(fft(out1(1:44100))));
soundsc(out,44100);