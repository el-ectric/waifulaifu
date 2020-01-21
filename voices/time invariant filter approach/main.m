% make chirp with timbre
chirp = 0;

% create filter
b = fir2(4410, [0 300 301 500 501 22050]/22050, [0 0 1 1.1 0 0]);

plot(abs(fft(b)));
% apply filter to change timbre
instantFreq = 0;
