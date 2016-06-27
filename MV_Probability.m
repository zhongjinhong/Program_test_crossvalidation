function [W]=MV_Probability(X,Y,svm_para)

    emusinou=10^(-20);
    [n,d]=size(X);
    %%%%%% modified %%%%%%%%%%%%%%
    Y_1 = (Y==1);
    Y_0 = (Y==0);
    
    miu = ( sum(Y_1,2)+emusinou )./( sum(Y_1,2)+sum(Y_0,2)+2*emusinou );

    
    count=zeros(2*n,1);
    for i = 1:n
        count(i,1) = 1-miu(i);
        count(n+i,1) = miu(i);
    end
    
    %%%%%% modified for exp %%%%%%%%%%%%%%
%     for i = 1:2*n
%         if(count(i,1)>0.5)
%             count(i,1)=exp(count(i,1))-exp(0.5);
%         else
%             count(i,1)=0;
%         end
%     end
    %%%%%% modified for exp %%%%%%%%%%%%%%
    
    
    train_data=[X;X];
    train_label=ones(2*n,1);
    train_label(1:n,1) = -train_label(1:n,1);
    weight=count;
%     weight=count/max(count);
    Model=svmtrain(weight,train_label,train_data,svm_para);
    
    if (sum(weight(1:n))==0)
        W =zeros(1,d+1);
        W(1,d+1) = 1;
    elseif (sum(weight(n+1:2*n))==0)
        W =zeros(1,d+1);
        W(1,d+1) = -1;
    else
        W=Model.sv_coef'*Model.SVs;
        b=-Model.rho;
        W=[W b];
        if(Model.Label(1,1)~=1)
            W=-W;
        end           
    end
    
end
