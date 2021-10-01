function [c, ceq] = LGL_cons(X, prob)
%LGL_CONS 此处显示有关此函数的摘要
%   此处显示详细说明

stateVec = X(prob.nsIndex);
stateMat = reshape(stateVec, prob.N+1, prob.ns);

controlVec = X(prob.nuIndex);
controlMat = reshape(controlVec, prob.N+1, prob.nc);

tmp1 = prob.DMat*stateMat;

tmp1 = tmp1(:);

dae1 = prob.dae(stateMat, controlMat);

tmp2 = 0.5*(prob.tf-prob.t0)*dae1;

tmp3 = tmp2-tmp1;

X0 = stateMat(1, :);
XF = stateMat(end, :);
TF = prob.tf;
T0 = prob.t0;

tmp6 = prob.event(X0,T0,XF,TF);

% tmp4 = [stateMat(1,1);  stateMat(1,2)];
% tmp5 = [stateMat(end, 1)-1;  stateMat(end, 2)];

ceq = [tmp3; tmp6];

c = [];

end

