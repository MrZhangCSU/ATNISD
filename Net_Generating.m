function  [history]= Net_Generating(Net_parameters) 
%           Point_Init -- �����ʼ�ڵ�
%           iterationTime -- ��������
%           ������ڵ�켣����
     Point_Init = Net_parameters.Point_Init;
     iterationTime = Net_parameters.iterationTime;
     N = Net_parameters.N;
     AA = Net_parameters.AA;
     C = Net_parameters.C;
     h = Net_parameters.h;
     history(:,:,1)=Point_Init;
     history2 = zeros(3,20,3);
    for i = 2:iterationTime
        X_All=history(:,:,i-1);
        % ��¼N���ڵ��״̬
        for k = 1:N
           xInit =X_All(1,k);yInit=X_All(2,k);zInit=X_All(3,k);%��ʼ��
          [x,y,z]=Runge_Kutta_F(xInit,yInit,zInit,X_All,k,AA,C,h,N);
          history(1:3,k,i)=[x,y,z];
       end
    end
end