%% �ȼ���ֵ����

fh = @(tau) 1./(1+16.*tau.^2);
samples = [5, 8, 10];
M = 100;
plotNodes = linspace(-1, 1, M);
plotTrues = fh(plotNodes);

figure;
axes;
hold on;
grid on;
plot(plotNodes, plotTrues, '-', 'LineWidth', 2.0);

for N=samples
    npts = linspace(-1, 1, N+1);
    fvalues = fh(npts);
    
    plotValues = LagrangeInterpolation(plotNodes.', npts.', fvalues.');
    plot(plotNodes, plotValues, '-', 'LineWidth', 2.0);
    
end
legend('y(��)', 'N=5', 'N=8', 'N=10');

%% ��ͬ��N��Ӧ��LGL���

sampleN = 4:4:20;

figure(1);
axis;
hold on;

for N=sampleN
    
    curPoints = LGL_nodes(N);
    plot(curPoints, (N)*ones(size(curPoints)), 's-', 'LineWidth', 1.0, 'MarkerSize', 6);
end
grid on;
yticks(sampleN);

xlabel('LGL nodes');
ylabel('# of nodes');


%%  LGL��ֵ��Ӧ������

fh = @(tau) 1./(1+16.*tau.^2);
samples = [5, 8, 10];
M = 100;
plotNodes = linspace(-1, 1, M);
plotTrues = fh(plotNodes);

figure;
axes;
hold on;
grid on;
plot(plotNodes, plotTrues, '-', 'LineWidth', 2.0);

sampleN = [5 8 10 15 20];

for N=sampleN
    curPoints = LGL_nodes(N);
    fvalues = fh(curPoints);
    plotValues = LagrangeInterpolation(plotNodes.', curPoints, fvalues);
    plot(plotNodes, plotValues, '-', 'LineWidth', 2.0);
end

title('LGL points')
grid on;
legend('y(��)', 'N=5', 'N=8', 'N=10','N=15', 'N=20');


%% ���η�����ʾ
sampleN = 4:2:20;

fh = @(x) log(x+2);
ifh = @(x) (x+2).*(log(x+2)-1);
ground_truth = ifh(1)-ifh(-1);

errors = [];
for N=sampleN
    npts = linspace(-1, 1, N+1);
    h = 2/N;
    omega = h*ones(1, N+1); omega(1) = 0.5*h; omega(end) = 0.5*h;
    curError = abs(omega * fh(npts).' - ground_truth);
    
    errors = [errors; curError];
end

plot(sampleN, errors, 's-', 'LineWidth', 1.8, 'MarkerSize', 8);
grid on;
xlabel('Trapezoidal Rule');
ylabel('abs errors');


%% ��LGL_weights��ʹ��
% �Ի��ֽ��н���
clc;

sampleN = 4:2:20;

% figure(1);
% axis;
% hold on;

fh = @(x) log(x+2);
ifh = @(x) (x+2).*(log(x+2)-1);

ground_truth = ifh(1)-ifh(-1);

error2 = [];
format long;
for N=sampleN

    curPoints = LGL_nodes(N);
    curWeights = LGL_weights(curPoints);
    curRet = curWeights.' * fh(curPoints);
    curError = abs(curRet-ground_truth);
    error2 = [error2; curError];
%     fprintf('Error is %.15e, The true value is %.15f, Approximate value is %.15f \n', abs(ground_truth-curRet), ground_truth, curRet);

end
format short;
plot(sampleN, errors, 's-', 'LineWidth', 1.8, 'MarkerSize', 8);
hold on;
plot(sampleN, error2, 's-', 'LineWidth', 1.8, 'MarkerSize', 8);

grid on;
legend('Trapezoidal Rule', 'gauss quadrature');
% xlabel('gauss quadrature');
ylabel('abs errors');

%% 


%% ��΢�־����ʹ��
% ��Ҫ�Ƕ�΢�ֽ��н���
% ����˵������ĳ������LGL��㴦����ֵ������˵ f = sin(x)�� �ú����ĵ���Ϊ df = cos(x)
clc;

N = 5;
fh = @(x) sin(x);
dfh = @(x) cos(x);

curPoints = LGL_nodes(N);
curMats = LGL_Dmatrix(curPoints);

fh_value = fh(curPoints);
dfh_value = dfh(curPoints);
appro_dfh = curMats*fh_value;

for i=1:N+1
    fprintf('nodes: %.8f, true derivative: %.8f, approximate derivative: %.8f\n', curPoints(i), dfh_value(i), appro_dfh(i));
    
end

%% ����LGLα�׷��Ա�ֵ��������


