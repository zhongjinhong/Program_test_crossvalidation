clear;
instances_num = 100;
miu = [1 1;-1 -1];
X = zeros(2*instances_num, 2);
Z = zeros(2*instances_num, 1);
for i = 1:2
    index = 100*(i-1);
    for j = 1:instances_num
        X( index+j, :) = normrnd(miu(i,:),0.5);
        if sum(X(index+j,:))>=0
            Z(index+j,1) = 1;
        else
            Z(index+j,1) = -1;
        end
    end
end


figure()
hold on
for i = 1:200
    if Z(i,1) == 1
        plot(X(i,1),X(i,2),'*r')
    else
        plot(X(i,1),X(i,2),'*b')
    end
end



bias = 0:0.5:4;
expert_num = size(bias,2);
Y = zeros(2*instances_num, expert_num);
for t = 1:expert_num
    for i = 1:2*instances_num
        fx = sum(X(i,:),2);
        positive_proba = 1/( 1+exp(-fx-bias(1,t)) );
        if rand() < positive_proba
            Y(i,t) = 1;
        else
            Y(i,t) = -1;
        end
    end
end


accuracy = zeros(expert_num, 1);
for t = 1:expert_num
    for i = 1:2*instances_num
        if Y(i,t) == Z(i,1)
            accuracy(t,1)=accuracy(t,1) + 1;
        end
    end
    accuracy(t,1) = accuracy(t,1)/200;
end

addpath('tools/');
svm_para=sprintf('%s','-s 0 -t 0');

Y_temp = (sum(Y,2)>0);
Y_temp = 2*Y_temp - 1;

[W_LCM,weight]=LCM_test_binary(X,Y,svm_para);


weight = ones(200,1);
Model=svmtrain(weight,Y_temp,X,svm_para);

W=Model.sv_coef'*Model.SVs;
b=-Model.rho;
W=[W b];
if(Model.Label(1,1)~=1)
    W=-W;
end