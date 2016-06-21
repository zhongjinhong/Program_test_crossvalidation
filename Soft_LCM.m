function [ w ]=Soft_LCM(X,weight1)
    train_data=[X;X];
    weight=weight1;
    n=size(X,1);
    train_label=ones(2*n,1);
    train_label(1:n,1) = -train_label(1:n,1);
%     for i=1:n
%         if(weight(i,1)<0)
%             weight(i,1)=-weight(i,1);
%             train_label(i,1)=-1;
%         end
%     end
    maxx_weight=max(weight);
    weight=weight/sum(weight)*n;
    w=weighted_svm(train_data,train_label,weight);
end