close all;

figure;
plot(t, vout);
hold on;
plot(t, vin);
s = tf('s');

n = 8;
R = (1/n)^(1/n);
theta_k = [];

for k = 1:n
    theta_k(k) = ((2*k-1)*pi)/(2*n);
end

p_k = (- R * sin(theta_k)) + (1i * R * cos(theta_k));

Q_p = (s - p_k(1)) * (s - p_k(2)) * (s - p_k(3)) * (s - p_k(4));

K = prod(p_k);

H_p = K / Q_p;

disp(H_p);

figure;
bode(H_p);

function MSE = calcMSE(x, y)

  SE =  (x - y).^2;
  MSE = avg(SE);
  
end