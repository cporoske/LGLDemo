function dae = mydae(X, U)
%MYDAE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

X1 = X(:,1);   X2 = X(:,2);
U1 = U(:, 1);

X1dot = X2;
X2dot = U1;

dae = [X1dot; X2dot];

end

