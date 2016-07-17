function [  ] = handle_result( experiment_num )
    Initialization();

    repeat_num=total_repeat_num;

    

    file_name=sprintf('%s%s',output_file_dir,'W_LFC.mat');
    load(file_name);
    file_name=sprintf('%s%s',output_file_dir,'W_PC.mat');
    load(file_name);
    file_name=sprintf('%s%s',output_file_dir,'W_MV.mat');
    load(file_name);
    file_name=sprintf('%s%s',output_file_dir,'W_M3V.mat');
    load(file_name);
    file_name=sprintf('%s%s',output_file_dir,'W_LCM.mat');
    load(file_name);

    file_name=sprintf('%s%s',output_file_dir,'W_LCM1.mat');
    load(file_name);    
    file_name=sprintf('%s%s',output_file_dir,'W_LCM2.mat');
    load(file_name);
    
    file_name=sprintf('%s%s',output_file_dir,'W_MV_Probability.mat');
    load(file_name);
    file_name=sprintf('%s%s',output_file_dir,'W_DS_Estimator.mat');
    load(file_name);
    
    
    total_iteration_num=size(W_LCM1,1);      

    
    Result_LFC=zeros(total_iteration_num,1);
    for t=1:total_iteration_num    
        repeat_num = ceil(t/total_repeat_num);
        k = mod(t-1, total_repeat_num)+1;
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'X_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'Y_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        [n d]=size(X_test);
        X_test(:,d+1)=ones(n,1);
        target=(0.5*Y_test+0.5)';
        predict_label=zeros(n,1);
        
        for i=1:n
            predict_label(i,1)=W_LFC(t,:)*X_test(i,:)';
            if(predict_label(i,1)*Y_test(i)>0)
                Result_LFC(t)=Result_LFC(t)+1;
            elseif(predict_label(i,1)*Y_test(i)==0)
                Result_LFC(t)=Result_LFC(t)+0.5;
            end
        end
        [tpr,fpr] = roc(target,predict_label');
        point_num = size(tpr,2);
        if tpr(point_num)~=1 || fpr(point_num)~=1
            tpr(1,point_num+1) = 1;
            fpr(1,point_num+1) = 1;
        end
        AUC_LFC(t) = trapz(fpr,tpr);
        Result_LFC(t)= Result_LFC(t)/n;
    end

    Result_PC=zeros(total_iteration_num,1);
    for t=1:total_iteration_num  
        repeat_num = ceil(t/total_repeat_num);
        k = mod(t-1, total_repeat_num)+1;
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'X_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'Y_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        [n d]=size(X_test);
        X_test(:,d+1)=ones(n,1);
        target=(0.5*Y_test+0.5)';
        predict_label=zeros(n,1);
        
        for i=1:n
             predict_label(i,1)=W_PC(t,:)*X_test(i,:)';
            if(predict_label(i,1)*Y_test(i)>0)
                Result_PC(t)=Result_PC(t)+1;
            elseif(predict_label(i,1)*Y_test(i)==0)
                Result_PC(t)=Result_PC(t)+0.5;
            end
        end
        [tpr,fpr] = roc(target,predict_label');
        point_num = size(tpr,2);
        if tpr(point_num)~=1 || fpr(point_num)~=1
            tpr(1,point_num+1) = 1;
            fpr(1,point_num+1) = 1;
        end
        AUC_PC(t) = trapz(fpr,tpr);
        Result_PC(t)= Result_PC(t)/n;
    end

    Result_MV=zeros(total_iteration_num,1);
    for t=1:total_iteration_num 
       repeat_num = ceil(t/total_repeat_num);
        k = mod(t-1, total_repeat_num)+1;
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'X_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'Y_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        [n d]=size(X_test);
        X_test(:,d+1)=ones(n,1);
        target=(0.5*Y_test+0.5)';
        predict_label=zeros(n,1);      
        
       
        for i=1:n
            predict_label(i,1)=W_MV(t,:)*X_test(i,:)';
            if(predict_label(i,1)*Y_test(i)>0)
                Result_MV(t)=Result_MV(t)+1;
            elseif(predict_label(i,1)*Y_test(i)==0)
                Result_MV(t)=Result_MV(t)+0.5;
            end
        end
        [tpr,fpr] = roc(target,predict_label');
        point_num = size(tpr,2);
        if tpr(point_num)~=1 || fpr(point_num)~=1
            tpr(1,point_num+1) = 1;
            fpr(1,point_num+1) = 1;
        end
        AUC_MV(t) = trapz(fpr,tpr);
        Result_MV(t)= Result_MV(t)/n;
    end

    Result_M3V=zeros(total_iteration_num,1);
    for t=1:total_iteration_num   
        repeat_num = ceil(t/total_repeat_num);
        k = mod(t-1, total_repeat_num)+1;
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'X_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'Y_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        [n d]=size(X_test);
        X_test(:,d+1)=ones(n,1);
        target=(0.5*Y_test+0.5)';
        predict_label=zeros(n,1);
              
        for i=1:n
            predict_label(i,1)=W_M3V(t,:)*X_test(i,:)';
            if(predict_label(i,1)*Y_test(i)>0)
                Result_M3V(t)=Result_M3V(t)+1;
            elseif(predict_label(i,1)*Y_test(i)==0)
                Result_M3V(t)=Result_M3V(t)+0.5;
            end
        end
        [tpr,fpr] = roc(target,predict_label');
        point_num = size(tpr,2);
        if tpr(point_num)~=1 || fpr(point_num)~=1
            tpr(1,point_num+1) = 1;
            fpr(1,point_num+1) = 1;
        end
        AUC_M3V(t) = trapz(fpr,tpr);
        Result_M3V(t)= Result_M3V(t)/n;
    end    

    Result_LCM=zeros(total_iteration_num,1);
    for t=1:total_iteration_num
        repeat_num = ceil(t/total_repeat_num);
        k = mod(t-1, total_repeat_num)+1;
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'X_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'Y_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        [n d]=size(X_test);
        X_test(:,d+1)=ones(n,1);
        target=(0.5*Y_test+0.5)';
        predict_label=zeros(n,1);
               
        for i=1:n
            predict_label(i,1)=W_LCM(t,:)*X_test(i,:)';
            if(predict_label(i,1)*Y_test(i)>0)
                Result_LCM(t)=Result_LCM(t)+1;
            elseif(predict_label(i,1)*Y_test(i)==0)
                Result_LCM(t)=Result_LCM(t)+0.5;
            end
        end
        [tpr,fpr] = roc(target,predict_label');
        point_num = size(tpr,2);
        if tpr(point_num)~=1 || fpr(point_num)~=1
            tpr(1,point_num+1) = 1;
            fpr(1,point_num+1) = 1;
        end
        AUC_LCM(t) = trapz(fpr,tpr);
        Result_LCM(t)= Result_LCM(t)/n;
    end

    Result_LCM1=zeros(total_iteration_num,1);
    for t=1:total_iteration_num
        repeat_num = ceil(t/total_repeat_num);
        k = mod(t-1, total_repeat_num)+1;
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'X_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'Y_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        [n d]=size(X_test);
        X_test(:,d+1)=ones(n,1);
        target=(0.5*Y_test+0.5)';
        predict_label=zeros(n,1);
               
        for i=1:n
            predict_label(i,1)=W_LCM1(t,:)*X_test(i,:)';
            if(predict_label(i,1)*Y_test(i)>0)
                Result_LCM1(t)=Result_LCM1(t)+1;
            elseif(predict_label(i,1)*Y_test(i)==0)
                Result_LCM1(t)=Result_LCM1(t)+0.5;
            end
        end
        [tpr,fpr] = roc(target,predict_label');
        point_num = size(tpr,2);
        if tpr(point_num)~=1 || fpr(point_num)~=1
            tpr(1,point_num+1) = 1;
            fpr(1,point_num+1) = 1;
        end
        AUC_LCM1(t) = trapz(fpr,tpr);
        Result_LCM1(t)= Result_LCM1(t)/n;
    end    
    
    Result_LCM2=zeros(total_iteration_num,1);
    for t=1:total_iteration_num
        repeat_num = ceil(t/total_repeat_num);
        k = mod(t-1, total_repeat_num)+1;
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'X_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'Y_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        [n d]=size(X_test);
        X_test(:,d+1)=ones(n,1);
        target=(0.5*Y_test+0.5)';
        predict_label=zeros(n,1);
               
        for i=1:n
            predict_label(i,1)=W_LCM2(t,:)*X_test(i,:)';
            if(predict_label(i,1)*Y_test(i)>0)
                Result_LCM2(t)=Result_LCM2(t)+1;
            elseif(predict_label(i,1)*Y_test(i)==0)
                Result_LCM2(t)=Result_LCM2(t)+0.5;
            end
        end
        [tpr,fpr] = roc(target,predict_label');
        point_num = size(tpr,2);
        if tpr(point_num)~=1 || fpr(point_num)~=1
            tpr(1,point_num+1) = 1;
            fpr(1,point_num+1) = 1;
        end
        AUC_LCM2(t) = trapz(fpr,tpr);
        Result_LCM2(t)= Result_LCM2(t)/n;
    end    

    
    Result_MV_Probability=zeros(total_iteration_num,1);
    for t=1:total_iteration_num    
        repeat_num = ceil(t/total_repeat_num);
        k = mod(t-1, total_repeat_num)+1;
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'X_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'Y_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        [n d]=size(X_test);
        X_test(:,d+1)=ones(n,1);
        target=(0.5*Y_test+0.5)';
        predict_label=zeros(n,1);
              
        for i=1:n
            predict_label(i,1)=W_MV_Probability(t,:)*X_test(i,:)';
            if(predict_label(i,1)*Y_test(i)>0)
                Result_MV_Probability(t)=Result_MV_Probability(t)+1;
            elseif(predict_label(i,1)*Y_test(i)==0)
                Result_MV_Probability(t)=Result_MV_Probability(t)+0.5;
            end
        end
        [tpr,fpr] = roc(target,predict_label');
        point_num = size(tpr,2);
        if tpr(point_num)~=1 || fpr(point_num)~=1
            tpr(1,point_num+1) = 1;
            fpr(1,point_num+1) = 1;
        end
        AUC_MV_Probability(t) = trapz(fpr,tpr);
        Result_MV_Probability(t)= Result_MV_Probability(t)/n;
    end   
    
    
    Result_DS_Estimator=zeros(total_iteration_num,1);
    for t=1:total_iteration_num   
        repeat_num = ceil(t/total_repeat_num);
        k = mod(t-1, total_repeat_num)+1;
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'X_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'Y_test_',repeat_num*step_num,'_',k,'.mat');
        load(file_name);
        [n d]=size(X_test);
        X_test(:,d+1)=ones(n,1);
        target=(0.5*Y_test+0.5)';
        predict_label=zeros(n,1);
        
       
        for i=1:n
            predict_label(i,1)=W_DS_Estimator(t,:)*X_test(i,:)';
            if(predict_label(i,1)*Y_test(i)>0)
                Result_DS_Estimator(t)=Result_DS_Estimator(t)+1;
            elseif(predict_label(i,1)*Y_test(i)==0)
                Result_DS_Estimator(t)=Result_DS_Estimator(t)+0.5;
            end
        end
        [tpr,fpr] = roc(target,predict_label');
        point_num = size(tpr,2);
        if tpr(point_num)~=1 || fpr(point_num)~=1
            tpr(1,point_num+1) = 1;
            fpr(1,point_num+1) = 1;
        end
        AUC_DS_Estimator(t) = trapz(fpr,tpr);
        Result_DS_Estimator(t)= Result_DS_Estimator(t)/n;
    end       
    
 
    
    
    
    
    n=size(Result_MV_Probability,1);
    repeat_num = n;
    n=n/repeat_num;
    for i=1:n
        acc_LFC(i)=mean(Result_LFC( (i-1)*repeat_num+1:i*repeat_num));
        acc_PC(i)=mean(Result_PC( (i-1)*repeat_num+1:i*repeat_num));
        acc_MV(i)=mean(Result_MV( (i-1)*repeat_num+1:i*repeat_num));
        acc_M3V(i)=mean(Result_M3V( (i-1)*repeat_num+1:i*repeat_num));

        acc_Soft_LCM(i)=mean( Result_LCM( (i-1)*repeat_num+1:i*repeat_num) );
        acc_Soft_LCM1(i)=mean( Result_LCM1( (i-1)*repeat_num+1:i*repeat_num) );
        acc_Soft_LCM2(i)=mean( Result_LCM2( (i-1)*repeat_num+1:i*repeat_num) );
        
        
        
        acc_MV_Probability(i)=mean(Result_MV_Probability( (i-1)*repeat_num+1:i*repeat_num));
        acc_DS_Estimator(i)=mean(Result_DS_Estimator( (i-1)*repeat_num+1:i*repeat_num));

        
        
        std_LFC(i)=std(Result_LFC( (i-1)*repeat_num+1:i*repeat_num));
        std_PC(i)=std(Result_PC( (i-1)*repeat_num+1:i*repeat_num));
        std_MV(i)=std(Result_MV( (i-1)*repeat_num+1:i*repeat_num));
        std_M3V(i)=std(Result_M3V( (i-1)*repeat_num+1:i*repeat_num));

        std_Soft_LCM(i)=std( Result_LCM( (i-1)*repeat_num+1:i*repeat_num) );
        std_Soft_LCM1(i)=std( Result_LCM1( (i-1)*repeat_num+1:i*repeat_num) );
        std_Soft_LCM2(i)=std( Result_LCM2( (i-1)*repeat_num+1:i*repeat_num) );
        
        std_MV_Probability(i)=std(Result_MV_Probability( (i-1)*repeat_num+1:i*repeat_num));
        std_DS_Estimator(i)=std(Result_DS_Estimator( (i-1)*repeat_num+1:i*repeat_num));        
        
        

    end


    
    MV_result = sprintf('%.4f+%.4f', acc_MV,std_MV);
    M3V_result = sprintf('%.4f+%.4f', acc_M3V,std_M3V);
    LFC_result = sprintf('%.4f+%.4f', acc_LFC,std_LFC);
    PC_result = sprintf('%.4f+%.4f', acc_PC,std_PC);
    Soft_LCM1_result = sprintf('%.4f+%.4f', acc_Soft_LCM1,std_Soft_LCM1);
    
    MV_Probability_result = sprintf('%.4f+%.4f', acc_MV_Probability,std_MV_Probability);
    DS_Estimator_result = sprintf('%.4f+%.4f', acc_DS_Estimator,std_DS_Estimator);
    Soft_LCM2_result = sprintf('%.4f+%.4f', acc_Soft_LCM2,std_Soft_LCM2);
     
  
    result1 = {MV_result,M3V_result,LFC_result,PC_result,Soft_LCM1_result}
    result2 = {MV_Probability_result,DS_Estimator_result,Soft_LCM2_result,Soft_LCM1_result}   
    
    
    h=zeros(6,1);
    p=zeros(6,1);
    [h(1),p(1),ci,status]=ttest(Result_LCM1,Result_MV);
    [h(2),p(2),ci,status]=ttest(Result_LCM1,Result_M3V);
    [h(3),p(3),ci,status]=ttest(Result_LCM1,Result_LFC);
    [h(4),p(4),ci,status]=ttest(Result_LCM1,Result_PC);
    [h(5),p(5),ci,status]=ttest(Result_LCM1,Result_MV_Probability);
    [h(6),p(6),ci,status]=ttest(Result_LCM1,Result_DS_Estimator);
    [h(7),p(7),ci,status]=ttest(Result_LCM1,Result_LCM2);
    
%     accuracy_result = [acc_MV,acc_M3V,acc_LFC,acc_PC,acc_Soft_LCM1]
%     std_result      = [std_MV,std_M3V,std_LFC,std_PC,std_Soft_LCM1]    
    
%     accuracy_result = [acc_MV_Probability,acc_DS_Estimator,acc_Soft_LCM2,acc_Soft_LCM1]
%     std_result      = [std_MV_Probability,std_DS_Estimator,std_Soft_LCM2,std_Soft_LCM1]
    
%     [h12,p12,ci12,status12]=ttest(Result_LCM1,Result_LCM2);
    
    file_name=sprintf('%s%s',output_file_dir,'plot_data.mat');
    save(file_name,'*');
end

