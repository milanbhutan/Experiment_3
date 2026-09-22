close all;

s = tf('s');
%% Buttersworth Low Pass, 4th order

f_c_lp = 100;
omega_x = 2 * pi * f_c_lp;
s_lp = tf('s') / omega_x;
n_lp = 4;
R_lp = (1/n_lp)^(1/n_lp);
theta_k_lp = [];

Q_p_lp = 1;

for k = 1:n_lp
    theta_k_lp(k) = ((2*k-1)*pi)/(2*n_lp);
end

p_k_lp = (- R_lp * sin(theta_k_lp)) + (1i * R_lp * cos(theta_k_lp));

for k = 1:n_lp
    Q_p_lp = Q_p_lp * (s_lp - p_k_lp(k));
end

K_lp = prod(p_k_lp);

H_b4th_lp = K_lp / Q_p_lp;

[num, den] = tfdata(H_b4th_lp, 'v');

num = real(num);
den = real(den);

H_b4th_lp_norm = tf(num, den);

figure;
bode(H_b4th_lp_norm);



%% Buttersworth Low Pass, 8th order

omega_x = 2 * pi * f_c_lp;
s_lp = tf('s') / omega_x;
n_lp = 8;
R_lp = (1/n_lp)^(1/n_lp);
theta_k_lp = [];

Q_p_lp = 1;

for k = 1:n_lp
    theta_k_lp(k) = ((2*k-1)*pi)/(2*n_lp);
end

p_k_lp = (- R_lp * sin(theta_k_lp)) + (1i * R_lp * cos(theta_k_lp));

for k = 1:n_lp
    Q_p_lp = Q_p_lp * (s_lp - p_k_lp(k));
end

K_lp = prod(p_k_lp);

H_b8th_lp = K_lp / Q_p_lp;

[num, den] = tfdata(H_b8th_lp, 'v');

num = real(num);
den = real(den);

H_b8th_lp_norm = tf(num, den);

figure;
bode(H_b8th_lp_norm);

%% Buttersworth Bandstop

w_L = 2 * pi * 1000;
BW = 2 * pi * 1000;
w_o = 2 * pi * 1500;
s_bs = (BW * tf('s')) /((tf('s')^2) + w_o^2);
n_bs = 4;
R_bs = (1/n_bs)^(1/n_bs);
theta_k_bs = [];

Q_p_bs = 1;

for k = 1:n_bs
    theta_k_bs(k) = ((2*k-1)*pi)/(2*n_bs);
end

p_k_bs = (- R_bs * sin(theta_k_bs)) + (1i * R_bs * cos(theta_k_bs));

for k = 1:n_bs
    Q_p_bs = Q_p_bs * (s_bs - p_k_bs(k));
end

K_bs = prod(p_k_bs);

H_p_bs = K_bs / Q_p_bs;

% Need to make bandstop strictly proper
H_p_bs = H_p_bs * (1000000/ (s + 1000000));

[num, den] = tfdata(H_p_bs, 'v');

num = real(num);
den = real(den);

H_bstop_norm = tf(num, den);

figure;
bode(H_bstop_norm);

%% Chebyshev 4th order
% Normalized Chebyshev-I prototype poles
p = [ -0.265 + 1.12j, ...
    -0.640 + 0.460j, ...
    -0.640 - 0.465j, ...
    -0.260 - 1.12j ];

K = 0.693;                 % prototype numerator gain

% Build prototype transfer function from its poles
numProto = K;
denProto = real(poly(p));  
Hproto = tf(numProto,denProto);

% Desired low-pass cutoff
fc = 10;                 
wc = 2*pi*fc;             

% LP-to-LP transformation
[numLP,denLP] = lp2lp(numProto,denProto,wc);
H_LP = tf(numLP,denLP);

% Display final transfer function
H_LP

figure
opts = bodeoptions;
opts.Grid = 'on';
opts.FreqUnits = 'Hz';     
opts.MagUnits = 'dB';
bodeplot(H_LP,opts)
title('Bode Plot of Chebyshev-I Low-Pass Filter')