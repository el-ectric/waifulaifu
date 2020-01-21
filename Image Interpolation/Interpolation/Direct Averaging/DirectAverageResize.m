%Created by Derek Yu 7/5/2019
%Script directly averages a circle and a larger circle

size = 400;

%create a circle
tt = (0:(size-1))*2*pi./(size);
x = cos(tt)+1;
y = sin(tt);

%create a larger circle
xx = 2.*cos(tt);
yy = 2.*sin(tt);


x_avg = (x+xx)/2;
y_avg = (y+yy)/2;


plot(x_avg, y_avg);
