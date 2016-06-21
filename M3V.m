function [ W ] = M3V( X,Y,svm_para )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    index = find(sum(Y~=-2,2)>0);
    X = X(index,:);
    Y = Y(index,:);
    
    [n,expert_num]=size(Y);
    g(1).index = (Y == -1);
    g(2).index = (Y==1);
    Z =( sum( g(2).index - g(1).index, 2 ) >= 0 );
    Z = 2*Z -1;
    iteration_num = 1;
    Z_new = Z;
    X_temp = zeros(2*n,expert_num);
    Y_temp = zeros(2*n,1);
    Y_temp(1:n,:) = 1;
    Y_temp(n+1:2*n,:) = -1;
    svm_para_temp = sprintf('%s','-s 0 -t 0');
    while(iteration_num <= 1000)
        %%%%%%%%% using libsvm to get eita %%%%%%%%%%%%%%%%%%%%%
        for i = 1:n
            index1 = (Z(i)+1)/2 + 1;
            index2 = (-Z(i)+1)/2 + 1;
            X_temp(i,:) = g(index1).index(i,:) - g(index2).index(i,:);
            X_temp(n+i,:) = -X_temp(i,:);
        end
%         model=svmtrain(ones(2*n,1),Y_temp,X_temp,svm_para_temp);
%         eita=model.sv_coef'*model.SVs;
%         if(model.Label(1,1)~=1)
%             eita=-eita;
%         end
%         
        %%%%%%%%% upate the estimation labels %%%%%%%%%%%%%%%%%%%%%
        X_sparse = sparse(X_temp);
        model = train(Y_temp,X_sparse);
%         [predict_label,decision,accuracy]=predict(Y_temp,X_sparse,model); 
        eita=model.w;
        if(model.Label(1,1)~=1)
            eita=-eita;
        end
        %%%%%%%%% upate the estimation labels %%%%%%%%%%%%%%%%%%%%%
        for i = 1:n
            loss_positive = max( 0, 1-eita*(g(2).index(i,:) - g(1).index(i,:))' );
            loss_negative = max( 0, 1-eita*(g(1).index(i,:) - g(2).index(i,:))' );
            if loss_positive <= loss_negative
                Z_new(i) = 1;
            else
                Z_new(i) = -1;
            end
        end

        if ( Z_new == Z )
            break
        else
            Z=Z_new;
        end
        iteration_num = iteration_num + 1;
    end
    
    X_sparse = sparse([X ones(n,1)]);
    model_result = train(Z,X_sparse);
    W= model_result.w;
    if(model_result.Label(1,1)~=1)
        W=-W;
    end    
    
    
%     
%     model_result=svmtrain(ones(n,1),Z,X,svm_para);
%     W=model_result.sv_coef'*model_result.SVs;
%     b=-model_result.rho;
%     W=[W b];
%     if(model_result.Label(1,1)~=1)
%         W=-W;
%     end

end

