function ret = LGL_obj(X, prob)
%LGL_ �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

stateVec = X(prob.nsIndex);
stateMat = reshape(stateVec, prob.N+1, prob.ns);
controlVec = X(prob.nuIndex);
controlMat = reshape(controlVec, prob.N+1, prob.nc);

% mycost(XF, TF, X, U)
XF = stateMat(end, :);
XX = stateMat;
U = controlMat;

[Mayer, Lagrange] = prob.cost(XF, prob.tf, XX, U);

tmp1 = 0.5*(prob.tf-prob.t0)*prob.weight*Lagrange;
tmp2 = Mayer;

ret = tmp1+tmp2;

% ret = ret/20;

end

