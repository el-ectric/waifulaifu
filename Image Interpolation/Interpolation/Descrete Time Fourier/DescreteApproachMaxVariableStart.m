h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'DirectAveragingStartPoint.gif';
for n = 1:0.1:5
    % given descrete x, y values for a circle
    period = 1/100;

    %create a box
    x = [0:period:1, ones(1,101), 1:-period:0, zeros(1,101)];
    y = [zeros(1,101), 0:period:1, ones(1,101), 1:-period:0];

    %create a circle
    tt = ((0:length(x)-1).*2*pi./length(x)) + (n-1)/2*pi;
    xx = cos(tt);
    yy = sin(tt);

    %do fft on box
    XFFT = fft(x);
    YFFT = fft(y);

    %do fft on circle
    XXFFT = fft(xx);
    YYFFT = fft(yy);

    %max fft
    XFFT_MAX = max(XFFT(:),XXFFT(:))/sqrt(2);
    YFFT_MAX = max(YFFT(:),YYFFT(:))/sqrt(2);
    
    %interpret fft for average
    x_max = ifft(XFFT_MAX);
    y_max = ifft(YFFT_MAX);

    plot(x_max, y_max); 
    axis([-.5 1.2 -.5 1.2])
    text(.3,.5,['phase: ', num2str((n-1)/2), '\pi']);
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