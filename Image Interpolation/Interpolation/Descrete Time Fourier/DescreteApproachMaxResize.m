%Created by Derek Yu 7/5/2019
%Script averages the FFT of a circle and a larger circle


% given descrete x, y values for a circle
period = 1/100;
size = 400;

%create a circle
tt = (0:(size-1))*2*pi./(size);
x = cos(tt);
y = sin(tt);

%create a larger circle
xx = 2.*cos(tt);
yy = 2.*sin(tt);

%do fft on box
XFFT = fft(x);
YFFT = fft(y);

%do fft on circle
XXFFT = fft(xx);
YYFFT = fft(yy);

%max fft
XFFT_AVG = max(XFFT(:),XXFFT(:));
YFFT_AVG = max(YFFT(:),YYFFT(:));

%interpret fft for box
x_out = ifft(XFFT);
y_out = ifft(YFFT);

%interpret fft for circle
xx_out = ifft(XXFFT);
yy_out = ifft(YYFFT);

%interpret fft for average
x_avg_out = ifft(XFFT_AVG);
y_avg_out = ifft(YFFT_AVG);

%plot for debug circle
figure(1);
plot(1:length(XFFT), XFFT);
figure(2);
plot(1:length(YFFT), YFFT);
figure(3);
plot(x_out, y_out);
figure(4);
plot(x, y);

%plot for debug large circle
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
