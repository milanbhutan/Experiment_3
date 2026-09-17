close all;

figure;
plot(t, vout);
plot(t, vin);




function MSE = calcMSE(x, y)

  SE =  (x - y).^2;
  MSE = avg(SE);
  
end