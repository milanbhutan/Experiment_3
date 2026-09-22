function Hz = Bilinear(H_s, f_s)
% bilinearTransform converts symbolic analog Hs(s) to digital Hz(z)
% fs = sampling frequency in Hz

syms s z

T = 1/f_s;

%% Create symbolic and display versions

[num, den] = tfdata(H_s, 'v');

H_s = poly2sym(num, s) / ...
    poly2sym(den, s);

% Bilinear transform:
% s = (2/T)(z - 1)/(z + 1)
sBilinear = (2/T)*(z - 1)/(z + 1);

% Substitute into the analog transfer function
Gz = simplify(subs(H_s, s, sBilinear));

%% Convert symbolic H(z) to numerical coefficients
Hz_numeric = vpa(Gz, 12);

[numZ_symbolic, denZ_symbolic] = numden(Hz_numeric);

numZ = double(sym2poly(expand(numZ_symbolic)));
denZ = double(sym2poly(expand(denZ_symbolic)));

% Normalize coefficients
numZ = numZ/denZ(1);
denZ = denZ/denZ(1);

%% Display digital transfer function
Hz = tf(numZ, denZ, T);

end