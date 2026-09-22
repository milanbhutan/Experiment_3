function totalError = totalSquaredError(data1, data2)
% Computes the total squared error between two equal-length datasets

if numel(data1) ~= numel(data2)
    error('The two datasets must have the same length.');
end

errorValues = data1(:) - data2(:);
totalError = sum(errorValues.^2);
end
