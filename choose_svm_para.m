function [svm_para]=choose_svm_para(X,Y)
    K=10;
    [n,d]=size(X);expert_num=size(Y,2);
    average_accuracy = zeros(16,1);
    for svm_para_configure_num = -5:10
        svm_para = sprintf('%s%d','-s 0 -t 0 -c ',2^svm_para_configure_num);
        
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
        accuracy_bagging=zeros(K,expert_num);
        Numm=zeros(K,expert_num);

        num_positive = zeros(n,expert_num);
        num_negative = num_positive;
        accuracy_annotator = zeros(1,expert_num);

        for t=1:expert_num
            available_num = 0;
            total_accuracy = 0;
            for k=1:K
                if size(model(k,t).Label,1) == 1
                    predict_lable(k,t).label = ones(n,1)*model(k,t).Label;
                elseif size(model(k,t).Label,1) == 0
                    continue;
                else
                    w0=model(k,t).sv_coef'*model(k,t).SVs;
                    b=-model(k,t).rho;
                    if(model(k,t).Label(1,1)~=1)
                        w0=-w0;
                        b=-b;
                    end
                    predict_lable(k,t).label = sign( w0*X(1:n,:)' +b )';                
                end

                balance = sum( predict_lable(k,t).label == 1)/n;
                if balance > 0.8 || balance < 0.2
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
                end

            end
            if available_num >= 0.5*K
                accuracy_annotator(1, t) = total_accuracy/available_num;
            else
                accuracy_annotator(1, t) = -1;
            end

        end 
        
        index = find(accuracy_annotator > 0);
        average_accuracy(svm_para_configure_num+6) = sum(accuracy_annotator(1,index))/sum(accuracy_annotator > 0);
    
    end

    max_svm_para_configure_num = find(average_accuracy==max(average_accuracy));
    svm_para = sprintf('%s%d','-s 0 -t 0 -c ',2^(max_svm_para_configure_num-6));

end
