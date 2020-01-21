%Created by Derek Yu 7/5/2019
%Script averages the FFT of a square and a circle with different sized
%arrays

%this version takes two inputs with different sizes and resizes them to be
%the same. This is because the FFTs used to average them require them to be
%created from the an array of the same size.


% given descrete x, y values for a circle
period = 1/100;

%create a box
x = [0:period:1, ones(1,101), 1:-period:0, zeros(1,101)];
y = [zeros(1,101), 0:period:1, ones(1,101), 1:-period:0];

%create a circle
tt = (0:(length(x)-1)/2).*2*pi./length(x)*2;
xx = cos(tt);
yy = sin(tt);

%calculate the required fft size
fftSize = min(length(x), length(xx));

%modify both shapes to smaller fft size
x_small = x(round((0:fftSize-1)*length(x)/fftSize+1, 0));
y_small = y(round((0:fftSize-1)*length(y)/fftSize+1, 0));
xx_small = xx(round((0:fftSize-1)*length(xx)/fftSize+1, 0));
yy_small = yy(round((0:fftSize-1)*length(yy)/fftSize+1, 0));

%do fft on box
XFFT = fft(x_small);
YFFT = fft(y_small);

%do fft on circle
XXFFT = fft(xx_small);
YYFFT = fft(yy_small);

%average fft
XFFT_AVG = (XFFT + XXFFT)/2;
YFFT_AVG = (YFFT + YYFFT)/2;

%interpret fft for box
x_out = ifft(XFFT);
y_out = ifft(YFFT);

%interpret fft for circle
xx_out = ifft(XXFFT);
yy_out = ifft(YYFFT);

%interpret fft for average
x_avg_out = ifft(XFFT_AVG);
y_avg_out = ifft(YFFT_AVG);

%plot for debug box
figure(1);
plot(1:length(XFFT), XFFT);
figure(2);
plot(1:length(YFFT), YFFT);
figure(3);
plot(x_out, y_out);
figure(4);
plot(x, y);

%plot for debug circle
figure(5);
plot(1:length(XXFFT), XXFFT);
figure(6);
plot(1:length(YYFFT), YYFFT);
figure(7);
plot(xx_out, yy_out);
figure(8);
plot(xx, yy);

%plot average fft
figure(9);
plot(1:length(XFFT_AVG), XFFT_AVG);
figure(10);
plot(1:length(YFFT_AVG), YFFT_AVG);
figure(11);
plot(x_avg_out, y_avg_out);