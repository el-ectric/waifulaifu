%Created by Derek Yu 7/5/2019
%Script directly averages a circle and a square


% given descrete x, y values for a circle
period = 1/100;

%create a box
x = [0:period:1, ones(1,101), 1:-period:0, zeros(1,101)];
y = [zeros(1,101), 0:period:1, ones(1,101), 1:-period:0];

%create a circle
tt = (0:length(x)-1).*2*pi./length(x);
xx = cos(tt);
yy = sin(tt);


x_avg = (x+xx)/2;
y_avg = (y+yy)/2;


plot(x_avg, y_avg);
