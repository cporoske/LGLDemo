function ret = myevent(X0, T0, XF, TF)
%MYEVENT 此处显示有关此函数的摘要
%   此处显示详细说明

ret = [X0(1); X0(2);
           XF(1)-1;
           XF(2);
           ];

end

