function dae = mydae(X, U)
%MYDAE 此处显示有关此函数的摘要
%   此处显示详细说明

X1 = X(:,1);   X2 = X(:,2);
U1 = U(:, 1);

X1dot = X2;
X2dot = U1;

dae = [X1dot; X2dot];

end

