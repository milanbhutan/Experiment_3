function Hz = bilinearTransform(Hs, fs)
% bilinearTransform converts symbolic analog Hs(s) to digital Hz(z)
% fs = sampling frequency in Hz

syms s z

T = 1/fs;

% Bilinear transform:
% s = (2/T)(z - 1)/(z + 1)
sBilinear = (2/T)*(z - 1)/(z + 1);

% Substitute into the analog transfer function
Hz = simplify(subs(Hs, s, sBilinear));

save('impulse_invariant_conversion.mat', 'G_z')
end