function [ w0 ] = Majority_Method(X,Y,svm_para)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    index = find(sum(Y~=-2,2)>0);
    X = X(index,:);
    Y = Y(index,:);
    
    [n,expert_num]=size(Y);
    for i = 1:n
        for t = 1:expert_num
            if Y(i,t)~=1 && Y(i,t)~=-1
                Y(i,t) = 0;
            end
        end
    end
    Y=sum(Y,2);
    for i=1:n
        if(Y(i,1)<0)
            Y(i,1)=-1;
        elseif(Y(i,1)>0)
            Y(i,1)=1;
        else
            if(rand()<=0.5)
                Y(i,1)=1;
            else
                Y(i,1)=-1;
            end
        end
    end

    
    
    X_sparse = sparse([X ones(n,1)]);
    model_result = train(Y,X_sparse);
    w0= model_result.w;
    if(model_result.Label(1,1)~=1)
        w0=-w0;
    end    
    
    
    
    
    
%     model=svmtrain(ones(n,1),Y,X,svm_para);
%     w0=model.sv_coef'*model.SVs;
%     b=-model.rho;
%     w0=[w0 b];
%     if(model.Label(1,1)~=1)
%         w0=-w0;
%     end
    
    
    
    
    
    
    
    
%     [predict_label,decision,accuracy]=svmpredict(Y,X,model);
%     accuracy = sum(w0*[X ones(43958,1)]'.*Y'>0)/43958;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%     X=X_test;
%     Y = Y_test;
%     X_sparse = sparse(X);
%     model1 = train(Y,X_sparse);
%     [predict_label,decision,accuracy]=predict(Y,X_sparse,model1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    
    
end

