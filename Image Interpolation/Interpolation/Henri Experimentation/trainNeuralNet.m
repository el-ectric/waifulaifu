function[out] = trainNeuralNet(line1, line2, neuralNet,increment)
% out is the neural net coefficients
netColumns = 2*length(line1);
increment;

if neuralNet == 0
  neuralNet = ones(3, netColumns);
  data = neuralNet;
end

data = [line1 line2; data];
midFrame = data(:,5);

for netCoefficientIndex = 1:sum(size(neuralNet))
  
  oldMidFrame = midFrame;
  
  for k1 = 2:netColumns
    for k2 = 1:3
      data(k1,k2) = sum(data(k1-1,:).*neuralNet(k2,:));
    end
  end
  
  midFrame = data(:,4);
  
  subplot(1,2,1);
  plot(ifft(oldMidFrame));
  
  subplot(1,2,2);
  plot(ifft(midFrame));
  
  better = input("better? (0/1)");
  
  if better
    neuralNet(netCoefficientIndex) = neuralNet(netCoefficientIndex)+increment;
  end
  
  if better = -1
    netCoefficientIndex = sum(size(neuralNet));
end
out = neuralNet;
end