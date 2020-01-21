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

x_avg = x1 + x2;
y_avg = y1 + y2;

figure(1);
plot(x1,y1);
figure(2);
plot(x2,y2);
figure(3);
plot(x_avg, y_avg);