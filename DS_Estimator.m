function [W]=DS_Estimator(X,Y,svm_para)

    emusinou=10^(-20);
%     [n,m]=size(Y);
    [n,d]=size(X);
    %%%%%% modified %%%%%%%%%%%%%%
    Y_1 = (Y==1);
    Y_0 = (Y==0);
    
    miu = ( sum(Y_1,2)+emusinou )./( sum(Y_1,2)+sum(Y_0,2)+2*emusinou );

    t=1;
    miu_old = miu;
    while t<=100
        %%%%%% modified %%%%%%%%%%%%%%
        alpha=( miu'*Y_1 + emusinou )./( miu'*(Y_1+Y_0)+2*emusinou );
        beta=( (1-miu)'*Y_0 + emusinou )./( (1-miu)'*(Y_1+Y_0)+2*emusinou );
        pi = sum(miu)/n;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        [ai,bi]=calculate_ai_bi(alpha,beta,Y);
        for i=1:n
            miu(i)=ai(i,1)*pi/( ai(i,1)*pi+bi(i,1)*(1-pi)+emusinou );
        end

 
        if max( abs(miu-miu_old) )>0.001;
            miu_old=miu;
        else
            break
        end
        t=t+1;   
        
        show_message=sprintf('t=%d',t);
        disp(show_message);
    end
    
    
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
    
%     save('debug.mat','*','-v7.3');

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



% 
% 
% 
%     W=Model.sv_coef'*Model.SVs;
%     b=-Model.rho;
%     W=[W b];
%     if(Model.Label(1,1)~=1)
%         W=-W;
%     end    
%     
    
end
