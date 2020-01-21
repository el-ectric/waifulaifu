clear;
hold off;

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


complex1 = x1 + (y1*j);
complex2 = x2 + (y2*j);

fourier1 = fft(complex1);
fourier2 = fft(complex2);

plot((fourier1(1:(length(fourier1)/6))));

plot((fourier2(1:(length(fourier1)/6))));

%average each element
midComplex = (complex1+complex2)./2;
plot(midComplex);

midFourier = (fourier1+fourier2)./2;
plot(ifft(midFourier));

%take max of each element
maxComplex = max(complex1,complex2);
plot(maxComplex);

maxFourier = max(fourier1,fourier2);
plot(ifft(maxFourier));

%filter each element
neuralNet = trainNeuralNet(complex1,complex2,0,10000000);