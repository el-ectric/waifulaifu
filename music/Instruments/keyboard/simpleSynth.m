% User inputs rhythm, pitch, volume, and instrument selection.


fourierSeries = [7 1.5 2.5 8 1.5 2 1.5 2.5 0.75 0.5 0.25];
pitches = [440 349.228 293.665];

tt = 1:(1/44100):5;
out = zeros(1,length(tt));

left = zeros(1,length(tt));
right = zeros(1,length(tt));
for a = 1:length(pitches)
    for k = 1:length(fourierSeries)
        for b = 1:1/100:3
            left = left + (fourierSeries(k).*cos((2*pi.*k.*(pitches(a)+b).*tt)+(2*pi*rand())));
            right = right + (fourierSeries(k).*cos((2*pi.*k.*(pitches(a)+b).*tt)+(2*pi*rand())));
        end
    end
end

right = left;
left = left./max(left);
right = right./max(right);
out = [left; right];

out = [zeros(2,44100) out];
soundsc(out,44100);