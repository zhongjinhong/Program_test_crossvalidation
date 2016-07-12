function [W]=LCM_compare(X,Y,svm_para)
    K=10;emusinon = 10^(-20);
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
            X_temp_sparse = sparse([X_temp(1:num,:) ones(num,1)]);
            model(k,t)=train( Y_temp(1:num,1), X_temp_sparse );
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
    accuracy_bagging=zeros(K,expert_num);
    Numm=zeros(K,expert_num);

    num_positive = zeros(n,expert_num);
    num_negative = num_positive;
%     accuracy_annotator = zeros(1,expert_num);
    X_sparse = sparse([X ones(n,1)]);
    for t=1:expert_num
        available_num = 0;
        total_accuracy = 0;
        
        
        for k=1:K
            if size(model(k,t).Label,1) == 1
                predict_lable(k,t).label = ones(n,1)*model(k,t).Label;
            elseif size(model(k,t).Label,1) == 0
                accuracy_bagging(k,t) = 0.5;
                continue;
            else
                [predict_label_temp,decision,accuracy]=predict(ones(n,1),X_sparse,model(k,t));
                predict_lable(k,t).label = predict_label_temp;
            end

            balance = sum( predict_lable(k,t).label == 1)/n;


            if balance ==1 || balance == 0
                accuracy_bagging(k,t) = 0.5;
                continue;
            end

            for i=1:n
                if(predict_lable(k,t).label(i,1)==1)
                  num_positive(i,t) = num_positive(i,t) + 1;
                else
                  num_negative(i,t) = num_negative(i,t) + 1;
                end

                if (A(t).Index(i,k)==0)
                    Numm(k,t)=Numm(k,t)+1;
                    if(Y(i,t)==predict_lable(k,t).label(i,1))
                        accuracy_bagging(k,t)=accuracy_bagging(k,t)+1;
                    end
                end
            end


            if(Numm(k,t)>=5)
                p = accuracy_bagging(k,t)/Numm(k,t);
                accuracy_bagging(k,t) = accuracy_bagging(k,t)/Numm(k,t);
                available_num = available_num + 1;
                total_accuracy = total_accuracy + p;
            else
                accuracy_bagging(k,t) = 0.5;
            end      
            
        end

    end


%%%%%%%%%%%%% Initial all data %%%%%%%%%%%%%

%     for t = 1:expert_num
%         for i = 1:n
%             if Y(i,t) == -2
%                 Y(i,t) = 1;
%             end
%         end
%     end

%%%%%%%%%%%%%Calculate each label's weight
    Con=zeros(n,expert_num);
    for i = 1:n
        total_positive = sum( num_positive(i,:),2 );
        total_negative = sum( num_negative(i,:),2 );
        pz_positive = total_positive/( total_positive + total_negative );
        pz_negative = 1 - pz_positive;
        for t = 1:expert_num
            if Y(i,t) == -2
                continue;
            end

            p1 = 1;
            p0 = 1;
            
            for k=1:K
                if(Numm(k,t)>=5)
                    if(predict_lable(k,t).label(i,1)==1)
                        p1 = p1*(accuracy_bagging(k,t)+emusinon);
                        p0 = p0*(1-accuracy_bagging(k,t)+emusinon);
                    else
                        p1 = p1*(1-accuracy_bagging(k,t)+emusinon);
                        p0 = p0*(accuracy_bagging(k,t)+emusinon);
                    end
                end
            end
            p1=p1^(1/K);
            p0=p0^(1/K);

            if Y(i,t) == 1
                Con(i,t) =( (p1+emusinon)/(p1+p0+emusinon) );
            else
                Con(i,t) =( (p0+emusinon)/(p1+p0+emusinon) );
            end

            if Con(i,t) < 0.5
                Y(i,t) = -Y(i,t);
                Con(i,t) = 1 - Con(i,t);
            end
            Con(i,t) = exp(Con(i,t)) - exp(0.5);
        end
    end


    count=zeros(2*n,1);
    for i = 1:n
        for t=1:expert_num
            switch Y(i,t)
                case -1
                    count(i,1)=count(i,1)+Con(i,t);
                case 1
                    count(n+i,1)=count(n+i,1)+Con(i,t);
                case -2
                    continue;
            end
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
