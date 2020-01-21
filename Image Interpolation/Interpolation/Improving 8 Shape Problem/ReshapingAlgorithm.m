pclear;

tt = 0:(2*pi*0.01):(2*pi);

%Left circle
xL = -cos(tt)-1;
yL = sin(tt);

%Right circle
xR = -cos(tt)+1;
yR = sin(tt);

%plot(xR,yR);

%Attach 
leftTopX = xL(1:floor(0.5*length(xL)));
rightTopX = xR(1:floor(0.5*length(xR)));

rightBottomX = xR(ceil(0.5*length(xR)):length(xR));
leftBottomX = xL(ceil(0.5*length(xL)):length(xL));

leftTopY = yL(1:floor(0.5*length(yL)));
rightTopY = yR(1:floor(0.5*length(yR)));

rightBottomY  = yR(ceil(0.5*length(yR)):length(yR));
leftBottomY = yR(ceil(0.5*length(yL)):length(yL));

x1 = [leftTopX rightTopX rightBottomX leftBottomX];
y1 = [leftTopY rightTopY rightBottomY leftBottomY];

x2 = [leftTopX flip(rightBottomX) flip(rightTopX) leftBottomX];
y2 = [leftTopY flip(rightBottomY) flip(rightTopY) leftBottomY];

x_deviation = sum(abs(abs(x1)-abs(x2)));
y_deviation = sum(abs(abs(y1)-abs(y2)));

diff_mask = false(1, length(x1));

for n = 1:length(x1)
   if (abs(x1(n)-x2(n))+abs(y1(n)-y2(n))>x_deviation+y_deviation)
        diff_mask(n) = 1;
   end
end

indicies = find(diff_mask);
x2_out = zeros(1, length(x2));
y2_out = zeros(1, length(y2));

for n = 1:length(indicies)
    x2_out(indicies(n)) = x2(indicies(length(indicies)-n+1));        
    y2_out(indicies(n)) = y2(indicies(length(indicies)-n+1));  
end

x2(diff_mask) = x2_out(diff_mask);
y2(diff_mask) = y2_out(diff_mask);

