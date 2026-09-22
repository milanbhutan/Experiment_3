clear; clc; close all

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
fc = 600;                 
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

save('transform_and_plot_prototype.mat', 'H_LP')
