% Draw a circle

tt = 0:(0.0002*pi):(2*pi);
b = 1;
a = 1;
r = 1;

f = (r*(cos(tt-(0.2*pi))+(j.*sin(tt)))) + (j*b) + a;

%plot(f)
%axis([-1 1 -1 1]);


% Calculate fourier series of first circle
fourierSeries1 = [];
coefficient = (1./(length(f))).*mean(f);
fourierSeries1 = coefficient;

numCoeff = 2;

for k = 1:numCoeff
  coefficient = mean(f.*exp(-j.*k.*tt));
  fourierSeries1 = [fourierSeries1 coefficient];
end

%{
% Calculate fourier series of first circle
fourierSeries1 = [];
for k = 1:10
  coefficientPart1 = (r*(exp(-j*(1+k)*2*pi)-1))./(-j.*(1+k));
  coefficientPart2 = (b*(exp(-j*2*pi.*k)-1))./k;
  coefficientPart3 = (a*(exp(-j*2*pi*k)-1))./(j.*k);
  
  coefficient = (coefficientPart1 - coefficientPart2 - coefficientPart3)./(2*pi);

  fourierSeries1 = [fourierSeries1 coefficient];
end
%}

%Fourier synthesis of first circle
circle1 = (a+(b*j)).*ones(1,length(tt));
for k = 1:numCoeff
  circle1 = circle1 + (fourierSeries1(k).*exp(-j.*(k).*tt));
end
close all;
plot(circle1);