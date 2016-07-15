clear;
probability_temp = 0.5;
positive_num = 50;
negative_num = 50;
num = 7;
dimension = 2;
delta = 1;
ratio = 0.8;

X(1:positive_num,:) = normrnd(1, delta,[positive_num,dimension]);
X(positive_num+1:positive_num+negative_num,:) = normrnd(-1, delta,[negative_num,dimension]);
Y(1:positive_num,1) = 1;
Y(positive_num+1:positive_num+negative_num,1) = -1;
Y = [Y Y Y];

index = randperm(positive_num + negative_num);
index = index(1:20);
Y(index) = -Y(index);


n=size(X,1);
expert_num=size(Y,2);

rn_temp = rand(n,expert_num*(num-1));
Y_temp = zeros(n,expert_num*(num-1));
for i=1:n
    for t=1:expert_num*(num-1)
        if(rn_temp(i,t)< probability_temp)
            Y_temp(i,t)= 1;
        else
            Y_temp(i,t)= -1;
        end
    end 
end  
Y = [Y Y_temp]; 
expert_num=size(Y,2);  

for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


[n,d]=size(X);
X(:,d+1)=1;d=d+1;  

W_LFC=LFC(X,Y);


X_test = X;
Y_test = ones(positive_num+negative_num,1);
Y_test(positive_num+1:positive_num+negative_num,1) = -Y_test(positive_num+1:positive_num+negative_num,1);
Result_LFC=0;
predict_label = zeros(n,1);
for i=1:n
    predict_label(i,1)=W_LFC'*X_test(i,:)';
    if(predict_label(i,1)*Y_test(i)>0)
        Result_LFC=Result_LFC+1;
    elseif(predict_label(i,1)*Y_test(i)==0)
        Result_LFC=Result_LFC+0.5;
    end
end
Result_LFC= Result_LFC/n;







