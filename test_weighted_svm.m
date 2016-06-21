X=[1 1;-1 1;-1 -1;1 -1];
Y=[1;1;-1;-1];
training_weight_vector=[1;0;1;0];
svm_para=sprintf('%s','-s 0 -t 0');
model=svmtrain(ones(4,1),Y, X,'-s 0 -t 0');
w0=model.sv_coef'*model.SVs;
b=-model.rho;
w0=[w0 b]; 

maxx_weight=max(weight);
weight=6000*weight/sum(weight);
model=svmtrain(weight,train_label, train_data,'-s 0 -t 0');