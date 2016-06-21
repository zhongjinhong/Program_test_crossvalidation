function [W,count]=LCM_old(X,Y,svm_para)
    K=10;
    [n,d]=size(X);expert_num=size(Y,2);
    X_temp=zeros(n,d);
    Y_temp=zeros(n,1);
    for t=1:expert_num
        A(t).Index=zeros(n,K);
        for k=1:K
            num = 0;
            for i=1:n
                temp_index=randperm(n,1);
                A(t).Index(temp_index,k)=1;
                if Y(temp_index,t) ~= -2 %% if the annotator does not label this instance.
                    num = num +1;
                    X_temp(num,:)=X(temp_index,:);
                    Y_temp(num,1)=Y(temp_index,t);
                end
            end
            model(k,t)=svmtrain(ones(num,1), Y_temp(1:num,1), X_temp(1:num,:), svm_para);
        end
    end

    %%%% omit each annotator's unlabel data.
    for t = 1:expert_num
        for i = 1:n
            if Y(i,t) == -2
                for k = 1:K
                    if A(t).Index(i,k) ==0
                        A(t).Index(i,k)= 2;
                    end
                end
            end
        end
    end
    
    %%%% Calculate the confidence of each boosting classifier
    Con=zeros(K,expert_num);
    Numm=zeros(K,expert_num);
    
    for t=1:expert_num
        for k=1:K
            if size(model(k,t).Label,1) == 1
                predict_lable = ones(n,1)*model(k,t).Label;
            elseif size(model(k,t).Label,1) == 0
                continue;
            else
                w0=model(k,t).sv_coef'*model(k,t).SVs;
                b=-model(k,t).rho;
                if(model(k,t).Label(1,1)~=1)
                    w0=-w0;
                    b=-b;
                end
                predict_lable = sign( w0*X(1:n,:)' +b )';                
            end            
            %%%%%%%%%%%%%% target modified %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            for i=1:n
                if (A(t).Index(i,k)==0)
                    Numm(k,t)=Numm(k,t)+1;
                    if(Y(i,t)==predict_lable(i,1))
                        Con(k,t)=Con(k,t)+1;
                    end
                end
            end
            
            
            if(Numm(k,t)>5)
                p = Con(k,t)/Numm(k,t);
%                 Con(k,t) = log( (1+p)/(2-p) )/log(2);
                Con(k,t) = exp(p)-exp(0.5);
                if Con(k,t) < 0
                    model(k,t).rho = -model(k,t).rho;
                    model(k,t).sv_coef = - model(k,t).sv_coef;
                    Con(k,t) = -Con(k,t);
                end
            else
                Con(k,t)=0;
            end            
            %%%%%%%%%%%%%% new modified end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
        end    
    end

    %%%%%%%%%%%%%% target modified %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    count=zeros(2*n,1);
    for t=1:expert_num
        for k=1:K
            if size(model(k,t).Label,1) <= 1
                continue
            end
            w0=model(k,t).sv_coef'*model(k,t).SVs;
            b=-model(k,t).rho;
            if(model(k,t).Label(1,1)~=1)
                w0=-w0;
                b=-b;
            end
            predict_lable = sign( w0*X(1:n,:)' + b )';            
            for i = 1:n
                if(predict_lable(i,1)==Y(i,t))
                    count(i+(Y(i,t)+1)*n/2,1)=count(i+(Y(i,t)+1)*n/2,1)+Con(k,t);
                end
            end
        end
    end       
    
    YYY=zeros(n,1);
    for i=1:n
        if(count(i+n,1)>=count(i,1))
            YYY(i,1)=1;
        else
            YYY(i,1)=-1;
        end
    end
   
 
    train_data=[X;X];
    train_label=ones(2*n,1);
    train_label(1:n,1) = -train_label(1:n,1);
    weight=count/sum(count)*n;
    Model=svmtrain(weight,train_label,train_data,svm_para);
    
    W=Model.sv_coef'*Model.SVs;
    b=-Model.rho;
    W=[W b];
    if(Model.Label(1,1)~=1)
        W=-W;
    end       
end