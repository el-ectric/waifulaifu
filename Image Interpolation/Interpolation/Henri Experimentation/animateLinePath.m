function[out] = animateLinePath(lineX, lineY, skipLength)

subplot(1,1,1);
junk = input("ready?");

intermediateX = [];
intermediateY = [];

for k = 1:length(lineX)

  intermediateX = [intermediateX lineX(k)];
  intermediateY = [intermediateY lineY(k)];
  
  if mod(k,skipLength) == 0   
    pause(0.000001);
    plot(intermediateX,intermediateY);
    axis([-3 3 -3 3], "square");
   % fflush(stdout);

  end
  
end

plot(lineX,lineY);
axis([-3 3 -3 3], "square");
%fflush(stdout);

end