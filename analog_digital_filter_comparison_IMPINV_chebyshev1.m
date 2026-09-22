clear
clc
close all

transform_and_plot_chev1_prototype;

% Load transfer functions created by the other scripts
analogData  = load('transform_and_plot_prototype.mat');
digitalData = load('impulse_invariant_conversion.mat');

H_LP = analogData.H_LP;
G_z  = digitalData.G_z;

% Plot both on the same Bode plot
figure

opts = bodeoptions;
opts.Grid = 'on';
opts.FreqUnits = 'Hz';
opts.MagUnits = 'dB';

bodeplot(H_LP, G_z, opts)

legend('Analog Chebyshev-I Filter', ...
    'Digital Impulse-Invariant Filter', ...
    'Location', 'best')

title('Analog and Digital Filter Comparison')
