clear;

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

rightBottomY = yR(ceil(0.5*length(yR)):length(yR));
leftBottomY = yR(ceil(0.5*length(yL)):length(yL));

x1 = [leftTopX rightTopX rightBottomX leftBottomX];
y1 = [leftTopY rightTopY rightBottomY leftBottomY];

x2 = [leftTopX flip(rightBottomX) flip(rightTopX) leftBottomX];
y2 = [leftTopY flip(rightBottomY) flip(rightTopY) leftBottomY];

%calculate the required fft size
fftSize = min(length(x1), length(x2));

%modify both shapes to smaller fft size
x1 = x1(round((0:fftSize-1)*length(x1)/fftSize+1, 0));
y1 = y1(round((0:fftSize-1)*length(y1)/fftSize+1, 0));
x2 = x2(round((0:fftSize-1)*length(x2)/fftSize+1, 0));
y2 = y2(round((0:fftSize-1)*length(y2)/fftSize+1, 0));

%do fft 
X1FFT = fft(x1);
Y1FFT = fft(y1);

X2FFT = fft(x2);
Y2FFT = fft(y2);


%max fft
%XFFT_MAX = max(X1FFT(1,:), X2FFT(1,:)).*filter;
%YFFT_MAX = max(Y1FFT(1,:), Y2FFT(1,:)).*filter;

h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'FFT8ShapeFilterWeightedInputs.gif';
for n = 1:.1:2
    
    filter = (1:fftSize)/fftSize;
    if n <= 1.5
        filter = .5*(3-exp(-1.*filter));
        filter(1) = 1;
        filter(end) = 1; 
    else
        filter = (40*(2-n))*(.5-abs(filter-.5))+ 1;
        filter(1) = 1;
        filter(end) = 1; 
    end
    
    XFFT_MAX = (X1FFT.*(n-1) + X2FFT.*(2-n)).*filter;
    YFFT_MAX = (Y1FFT.*(n-1) + Y2FFT.*(2-n)).*filter;

    %interpret fft for average
    x_max = ifft(XFFT_MAX);
    y_max = ifft(YFFT_MAX);

    plot(x_max, y_max);
    text(0,0,num2str(n-1));
    drawnow 
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if n == 1 
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
    else 
        imwrite(imind,cm,filename,'gif','WriteMode','append'); 
    end 
    
end
figure(1);
plot(1:length(Y1FFT), abs(Y1FFT));
%figure(2);
%plot(1:length(Y1FFT), angle(Y1FFT));
figure(3);
plot(1:length(Y2FFT), abs(Y2FFT));
%figure(4);
%plot(1:length(Y2FFT), angle(Y2FFT));
figure(5);
plot(x_max, y_max);
figure(6);
plot(1:length(filter), filter);