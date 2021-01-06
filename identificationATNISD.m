function [theta] = identificationATNISD(observation, strategy, lambda, penaltyF)
if nargin < 3
    lambda = [1, 1];     % l1���� l2���� ʱ�����к���tv�� ����TV��
end
% observation �ṹ ��x, i , t��
% strategy �ṹ (x, y, i, t)
evolveTime = size(observation,3); % how many time
p = size(observation,2);          % node number
observeNum = size(observation,1);
% theta = zeros(size(observation,2),size(observation,2),evolveTime);
theta = zeros(p,p,evolveTime);

%%  �޸�Ϊȫ�ַ�������
observeUse = zeros(observeNum*p, evolveTime);
strategyUse = zeros(observeNum*p, p*p, evolveTime);
for t = 1:evolveTime
    %ͬһʱ�̲�ͬ��Ĺ۲������ϵ�һ��
    observeTemp = observation(:,:,t);
    observeTemp = observeTemp(:);
    
    % ͬһʱ�̲�ͬ��Ĺ۲�������ϵ�һ��
    for k = 1:p
        aa = (k-1) * observeNum;
        bb = (k-1) * p;
        for row = 1:observeNum
            for col = 1: p
                strategyTemp(aa + row, bb + col) = strategy(row,col,k,t);
            end
        end
    end
    % ����ͬʱ����������ϵ�һ��
    observeUse(:,t) = observeTemp;
    strategyUse(:,:,t) = strategyTemp;
end

[x, history] = ATNISD(strategyUse, observeUse, lambda, 1, penaltyF);

for t = 1:evolveTime
    xTemp = x(:,t);
    theta(:,:,t) = reshape(xTemp,p,p);
end

% diagonal equal to 0
for i = 1:evolveTime
    temp = theta(:,:,i);
    temp(logical(eye(size(temp))))=0;
    theta(:,:,i)=temp;
end
