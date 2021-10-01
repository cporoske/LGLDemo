%%

% �����ڴ˴�������N��������Խ���
% ������Ҫʵ�ֵ��Ǻ��������� ��Ҫ��������Ӧ��Լ�����Ż�ָ�겿��

% ���ȿ�����ʵ�ֵ��ǵ�һ���Ƚϼ򵥵Ĳ���


problem.N = 8;

problem.x0 = [];

% ���Բ�����
problem.xmin = [];
problem.xmax = [];
problem.umin = [];
problem.umax = [];

problem.t0 = 0;
problem.tf = 5;


% �����ʼ����
% N+1��λ�õı���
problem.ns = 2;
problem.nc = 1;

problem.nVar = (problem.N+1)*(problem.ns+problem.nc);
problem.nsIndex = 1:(problem.N+1)*problem.ns;
problem.nuIndex = (problem.N+1)*problem.ns+1:(problem.N+1)*(problem.ns+problem.nc);

problem.npts = LGL_nodes(problem.N);
problem.weight = LGL_weights(problem.npts)';
problem.DMat = LGL_Dmatrix(problem.npts);
problem.dae = @mydae;
problem.cost = @mycost;
problem.event = @myevent;

% x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
% x0 = rand(problem.nVar, 1);
% (0,0) -> (1,0)
% ��ֵ����
x10 = ones(problem.N+1,1);
x20 = ones(problem.N+1,1);
u10 = zeros(problem.N+1,1);

x0 = [x10; x20; u10];

optNLP = optimset( 'LargeScale', 'off', 'GradObj','off', 'GradConstr','off',...
    'DerivativeCheck', 'off', 'Display', 'iter', 'TolX', 1e-9,...
    'TolFun', 1e-6, 'TolCon', 1e-6, 'MaxFunEvals',1e4,...
    'DiffMinChange',1e-5,'Algorithm','interior-point');

tic;
[X,fval,exitflag,output,lambda,grad,hessian] = fmincon(@(X) LGL_obj(X, problem), x0, [], [], [], [], [], [], @(X) LGL_cons(X, problem), optNLP);
toc;
%%  Costate Map 
lambda1= lambda.eqnonlin(2:problem.N);
lambda2= lambda.eqnonlin(problem.N+3:(problem.N+1)*2-1);

omega1 = problem.weight(2:end-1)';

cs1=  lambda1./omega1;
cs2=  lambda2./omega1;

%% 
stateVec = X(problem.nsIndex);
stateMat = reshape(stateVec, problem.N+1, problem.ns);

M = 40;
nodesPlot = linspace(-1, 1, M)';
statePlot = zeros(M, problem.ns);
% �������ղ�ֵ
for i=1:problem.ns
    curState = stateMat(:, i);
    curStatePlot = LagrangeInterpolation(nodesPlot, problem.npts, curState);
    statePlot(:, i) = curStatePlot;
end

controlVec = X(problem.nuIndex);
controlMat = reshape(controlVec, problem.N+1, problem.nc);
 % ʱ��任
nodesPlot1 = 0.5*(problem.tf-problem.t0)*nodesPlot+0.5*(problem.tf+problem.t0);
npts1 =  0.5*(problem.tf-problem.t0)*problem.npts+0.5*(problem.tf+problem.t0);

figure;
plot(nodesPlot1, statePlot(:,1), 's-', nodesPlot1, statePlot(:,2), 's-');
grid on;

figure;
plot(npts1, controlMat(:,1), 's-');
grid on;
