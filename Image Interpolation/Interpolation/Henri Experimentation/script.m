clear;

tt = 0:(2*pi*0.01):(2*pi)

%Left circle
xL = -cos(tt)-1;
yL = sin(tt);

%Right circle
xR = -cos(tt)+1;
yR = sin(tt);

plot(xR,yR);

%Attach 
leftTopX = xL(1:floor(0.5*length(xL)));
rightTopX = xR(1:floor(0.5*length(xR)));

rightBottomX = xR(ceil(0.5*length(xR)):length(xR));
leftBottomX = xL(ceil(0.5*length(xL)):length(xL));

leftTopY = yL(1:floor(0.5*length(yL)));
rightTopY = yR(1:floor(0.5*length(yR)));

rightBottomY = yR(ceil(0.5*length(yR)):length(yR));
leftBottomY = yR(ceil(0.5*length(yL)):length(yL));

x1 = [leftTopX rightTopX rightBottomX leftBottomX];
y1 = [leftTopY rightTopY rightBottomY leftBottomY];

x2 = [leftTopX flip(rightBottomX) flip(rightTopX) leftBottomX];
y2 = [leftTopY flip(rightBottomY) flip(rightTopY) leftBottomY];


plot(x1,y1);

animateLinePath(x1,y1,5);

animateLinePath(x2,y2,5);
%}

fourierX1 = (fft(x1));
fourierY1 = (fft(y1));
fourierX2 = (fft(x2));
fourierY2 = (fft(y2));


subplot(3,1,1);
plot(fourierY1(1:(length(fourierY1)/7)));
title("DFT for Y of Line 1");
hold on;
plot(fourierY2(1:(length(fourierY2)/7)));
title("DFT for Y");
hold off;

subplot(3,1,2);
plot(abs(fourierY1(1:(length(fourierX1)/7))));
title("Magnitude of DFT for Y of Line 1");
hold on;
plot(abs(fourierY2(1:(length(fourierX2)/7))));
title("Magnitude of DFT for Y of Line 2");
hold off;

subplot(3,1,3);
plot(angle(fourierY2(1:(length(fourierY2)/7))));
title("Angle of DFT for Y of Line 2");
hold on;
plot(angle(fourierY2(1:(length(fourierY2)/7))));
title("Phase of DFT for Y");
hold off;

clc;
junk = input("This is the x and y DFTs.");


% Take the max of 