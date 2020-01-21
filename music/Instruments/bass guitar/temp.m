thing = d(88200:length(d));
plot(thing);

y = zeros(1,1:441000);
for i = 1:13000:441000
  y(i:(i+length(thing)-1)) = thing;
endfor

plot(y);

soundsc(y,44100)