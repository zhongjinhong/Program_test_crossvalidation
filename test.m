
clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
                                                                                                                     1,1           Top








:set nonu                                                                                                     1,1           Top
clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
                                                                                                                     1,1           Top







clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
Time_PC= toc;
                                                                                                                                 1,1           Top







tic
W_PC=PC(X,Y);
                                                                                                                     1,1           Top
clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
Time_PC= toc;
                                                                                                                                 1,1           Top




clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
Time_PC= toc;
save('PC_finished','*');


                                                                                                                                                       1,1           Top




Time_PC= toc;
                                                                                                                                 1,1           Top
clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
Time_PC= toc;
save('PC_finished','*');


                                                                                                                                                       1,1           Top


clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
Time_PC= toc;
save('PC_finished','*');



[n,d]= size(X_test);
                                                                                                                                                                            1,1           Top



                                                                                                                                                       1,1           Top
clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
Time_PC= toc;
save('PC_finished','*');



[n,d]= size(X_test);
                                                                                                                                                                            1,1           Top
clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
Time_PC= toc;
save('PC_finished','*');



[n,d]= size(X_test);
X_test(:,d+1)=ones(n,1);
target=(0.5*Y_test+0.5)';
                                                                                                                                                                                         1,1           Top
clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
Time_PC= toc;
save('PC_finished','*');



[n,d]= size(X_test);
X_test(:,d+1)=ones(n,1);
target=(0.5*Y_test+0.5)';
                                                                                                                                                                                         1,1           Top
clear;
load data_new.mat
[n,d] = size(X);

index = randperm(n);
X_temp = X(index,:);
Y_temp = Y(index,:);
Z = Z(index,:);

train_num = 6000;
X = X_temp(1:train_num,:);
X_test = X_temp(train_num+1:end,:);

Y = Y_temp(1:train_num,:);
Y_test = Z(train_num+1:end,:);
clear X_temp Y_temp
expert_num = size(Y,2);

svm_para=sprintf('%s','-s 0 -t 0');
K=5;
tic
W_MV=Majority_Method(X,Y,svm_para);
Time_MV= toc;
tic
[W_LCM,count_new]=LCM_new(X,Y,svm_para);
Time_LCM= toc;

save('LCM_new_finished','*');
[n,d]=size(X);
X(:,d+1)=1;d=d+1;
for i=1:n
    for t=1:expert_num
        if(Y(i,t)==-1)
            Y(i,t)=0;
        end
    end
end


tic
W_LFC=LFC(X,Y);
Time_LFC= toc;
save('LFC_finished','*');

tic
W_PC=PC(X,Y);
Time_PC= toc;
save('PC_finished','*');



[n,d]= size(X_test);
X_test(:,d+1)=ones(n,1);
target=(0.5*Y_test+0.5)';

%%%%%%%%%%%%%% test MV method %%%%%%%%%%%%%%%%%%
predict_label=(W_MV*X_test')';
accuracy_MV = sum( predict_label.*Y_test>=0 )/n;

A=sum( (predict_label>0).*(Y_test==1) );
Precision_MV=A/sum( predict_label>0 );
Recall_MV=A/sum( Y_test==1 );

[tpr,fpr] = roc(target,predict_label');
point_num = size(tpr,2);
if tpr(point_num)~=1 || fpr(point_num)~=1
    tpr(1,point_num+1) = 1;
    fpr(1,point_num+1) = 1;
end
AUC_MV(1) = trapz(fpr,tpr);



%%%%%%%%%%%%%% test LCM method %%%%%%%%%%%%%%%%%%
predict_label=(W_LCM*X_test')';
accuracy_LCM = sum( predict_label.*Y_test>=0 )/n;

A=sum( (predict_label>0).*(Y_test==1) );
Precision_LCM=A/sum( predict_label>0 );
Recall_LCM=A/sum( Y_test==1 );

[tpr,fpr] = roc(target,predict_label');
point_num = size(tpr,2);
if tpr(point_num)~=1 || fpr(point_num)~=1
    tpr(1,point_num+1) = 1;
    fpr(1,point_num+1) = 1;
end
AUC_LCM(1) = trapz(fpr,tpr);

%%%%%%%%%%%%%% test LFC method %%%%%%%%%%%%%%%%%%
predict_label=(W_LFC'*X_test')';
accuracy_LFC = sum( predict_label.*Y_test>=0 )/n;

A=sum( (predict_label>0).*(Y_test==1) );
Precision_LFC=A/sum( predict_label>0 );
Recall_LFC=A/sum( Y_test==1 );

[tpr,fpr] = roc(target,predict_label');
point_num = size(tpr,2);
if tpr(point_num)~=1 || fpr(point_num)~=1
    tpr(1,point_num+1) = 1;
    fpr(1,point_num+1) = 1;
end
AUC_LFC(1) = trapz(fpr,tpr);
%%%%%%%%%%%%%% test PC method %%%%%%%%%%%%%%%%%%
predict_label=(W_PC'*X_test')';
accuracy_PC = sum( predict_label.*Y_test>=0 )/n;

A=sum( (predict_label>0).*(Y_test==1) );
Precision_PC=A/sum( predict_label>0 );
Recall_PC=A/sum( Y_test==1 );

[tpr,fpr] = roc(target,predict_label');
point_num = size(tpr,2);
if tpr(point_num)~=1 || fpr(point_num)~=1
    tpr(1,point_num+1) = 1;
    fpr(1,point_num+1) = 1;
end
AUC_PC(1) = trapz(fpr,tpr);


save('All_finished','*');


for i = 1:20
    for j = 1:5
        num = (i-1)*5 + j;
        A(i,j) = mean_result_test(num);
    end
end


for i = 1:5
    B(:,i) = A(:,5)-A(:,i);
end


A_rank=A;
A_sort = sort(A,2);
for i = 1:20
    for j = 1:4
        index = find(A_sort(i,:) == A(i,j));
        A_rank(i,j) = index(1,1);
    end
end



