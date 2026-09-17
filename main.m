close all;

%% Buttersworth Low Pass

f_c_lp = 1000;
omega_x = 2 * pi * f_c_lp;
s_lp = tf('s') / omega_x;
n_lp = 8;
R_lp = (1/n_lp)^(1/n_lp);
theta_k_lp = [];

Q_p_lp = 1;

for k = 1:n
    theta_k_lp(k) = ((2*k-1)*pi)/(2*n_lp);
end

p_k_lp = (- R_lp * sin(theta_k_lp)) + (1i * R_lp * cos(theta_k_lp));

for k = 1:n
    Q_p_lp = Q_p_lp * (s_lp - p_k_lp(k));
end

K_lp = prod(p_k_lp);

H_p_lp = K_lp / Q_p_lp;

[num, den] = tfdata(H_p_lp, 'v');

num = real(num);
den = real(den);

H_p_lp_norm = tf(num, den);

figure;
bode(H_p_lp_norm);

%% Buttersworth Bandstop

w_L = 2 * pi * 1000;
BW = 2 * pi * 1000;
w_o = 2 * pi * 1500;
s_bs = (BW * tf('s')) /((tf('s')^2) + w_o^2);
n_bs = 8;
R_bs = (1/n_bs)^(1/n_bs);
theta_k_bs = [];

Q_p_bs = 1;

for k = 1:n
    theta_k_bs(k) = ((2*k-1)*pi)/(2*n_bs);
end

p_k_bs = (- R_bs * sin(theta_k_bs)) + (1i * R_bs * cos(theta_k_bs));

for k = 1:n
    Q_p_bs = Q_p_bs * (s_bs - p_k_bs(k));
end

K_bs = prod(p_k_bs);

H_p_bs = K_bs / Q_p_bs;

[num, den] = tfdata(H_p_bs, 'v');

num = real(num);
den = real(den);

H_p_bs_norm = tf(num, den);

figure;
bode(H_p_bs_norm);


function total_SE = calcMSE(x, y)

  SE =  (x - y).^2;
  total_SE = sum(SE);
  
end