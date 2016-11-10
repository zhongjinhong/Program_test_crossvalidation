function [  ] = handle_result_robustness( experiment_num )
    Initialization();
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% debug %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     total_repeat_num=2;begin_num=10;end_num=11;count=zeros(end_num*10,(end_num-begin_num+1)*total_repeat_num); 
%     total_repeat_num = 10;
%     end_num = 6;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% debug %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    file_name=sprintf('%s%s',output_file_dir,'W_LFC.mat');
    load(file_name);
    file_name=sprintf('%s%s',output_file_dir,'W_PC.mat');
    load(file_name);
    file_name=sprintf('%s%s',output_file_dir,'W_MV.mat');
    load(file_name);
    file_name=sprintf('%s%s',output_file_dir,'W_M3V.mat');
    load(file_name);
%     file_name=sprintf('%s%s',output_file_dir,'W_LCM.mat');
%     load(file_name);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Debug %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%     file_name=sprintf('%s%s',output_file_dir,'W_LFC1.mat');
%     load(file_name);
%     W_LCM = W_LCM2;
% 
    file_name=sprintf('%s%s',output_file_dir,'W_LCM1.mat');
    load(file_name);
    W_LCM = W_LCM1;
%     total_repeat_num = size(W_LFC,1);
%     end_num = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    Result_LFC=zeros(total_repeat_num*(end_num-begin_num+1),1);
    Result_PC = Result_LFC;
    Result_MV = Result_LFC;
    Result_M3V = Result_LFC;
    Result_LCM = Result_LFC;
%     Result_MV_Probability = Result_LFC;
%     Result_DS_Estimator = Result_LFC;
    for repeat_num = 1:total_repeat_num
        for num=begin_num:end_num
            file_name=sprintf('%s%s%d%s',input_file_dir,'X_test_',repeat_num,'.mat');
            load(file_name); 
            file_name=sprintf('%s%s%d%s',input_file_dir,'Y_test_',repeat_num,'.mat');
            load(file_name); 
            
            [n d]=size(X_test);
            X_test(:,d+1)=ones(n,1);
            target=(0.5*Y_test+0.5)';
            predict_label=zeros(n,1);            

            t = (num-begin_num)*total_repeat_num + repeat_num;

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
%             
%             
%             for i=1:n
%                 predict_label(i,1)=W_MV_Probability(t,:)*X_test(i,:)';
%                 if(predict_label(i,1)*Y_test(i)>0)
%                     Result_MV_Probability(t)=Result_MV_Probability(t)+1;
%                 elseif(predict_label(i,1)*Y_test(i)==0)
%                     Result_MV_Probability(t)=Result_MV_Probability(t)+0.5;
%                 end
%             end
%             [tpr,fpr] = roc(target,predict_label');
%             point_num = size(tpr,2);
%             if tpr(point_num)~=1 || fpr(point_num)~=1
%                 tpr(1,point_num+1) = 1;
%                 fpr(1,point_num+1) = 1;
%             end
%             AUC_MV_Probability(t) = trapz(fpr,tpr);
%             Result_MV_Probability(t)= Result_MV_Probability(t)/n;            
%             
%             for i=1:n
%                 predict_label(i,1)=W_DS_Estimator(t,:)*X_test(i,:)';
%                 if(predict_label(i,1)*Y_test(i)>0)
%                     Result_DS_Estimator(t)=Result_DS_Estimator(t)+1;
%                 elseif(predict_label(i,1)*Y_test(i)==0)
%                     Result_DS_Estimator(t)=Result_DS_Estimator(t)+0.5;
%                 end
%             end
%             [tpr,fpr] = roc(target,predict_label');
%             point_num = size(tpr,2);
%             if tpr(point_num)~=1 || fpr(point_num)~=1
%                 tpr(1,point_num+1) = 1;
%                 fpr(1,point_num+1) = 1;
%             end
%             AUC_DS_Estimator(t) = trapz(fpr,tpr);
%             Result_DS_Estimator(t)= Result_DS_Estimator(t)/n;
            
            
            
        end
    end
    
    
    for i=1:end_num
        acc_LFC(i)=mean(Result_LFC( (i-1)*repeat_num+1:i*repeat_num));
        acc_PC(i)=mean(Result_PC( (i-1)*repeat_num+1:i*repeat_num));
        acc_MV(i)=mean(Result_MV( (i-1)*repeat_num+1:i*repeat_num));
        acc_M3V(i)=mean(Result_M3V( (i-1)*repeat_num+1:i*repeat_num)); 
        acc_Soft_LCM(i)=mean( Result_LCM( (i-1)*repeat_num+1:i*repeat_num) );
%         acc_MV_Probability(i)=mean(Result_MV_Probability( (i-1)*repeat_num+1:i*repeat_num));
%         acc_DS_Estimator(i)=mean(Result_DS_Estimator( (i-1)*repeat_num+1:i*repeat_num));


        std_LFC(i)=std(Result_LFC( (i-1)*repeat_num+1:i*repeat_num));
        std_PC(i)=std(Result_PC( (i-1)*repeat_num+1:i*repeat_num));
        std_MV(i)=std(Result_MV( (i-1)*repeat_num+1:i*repeat_num));
        std_M3V(i)=std(Result_M3V( (i-1)*repeat_num+1:i*repeat_num));  
        std_Soft_LCM(i)=std( Result_LCM( (i-1)*repeat_num+1:i*repeat_num) );
%         std_MV_Probability(i)=std(Result_MV_Probability( (i-1)*repeat_num+1:i*repeat_num));
%         std_DS_Estimator(i)=std(Result_DS_Estimator( (i-1)*repeat_num+1:i*repeat_num));        

    end
    linewidth=2;
    x_label = 0:end_num-1;
        
          
 
    
    linewidth=1;
    MarkerSize = 6;
    figure();
    hold on
    han(1,1)=plot(x_label, acc_MV,'--k','LineWidth',linewidth,'MarkerFaceColor','w','MarkerSize',MarkerSize);
    han(2,1)=plot(x_label, acc_M3V,'-k^','LineWidth',linewidth,'MarkerFaceColor','w','MarkerSize',MarkerSize);
    han(3,1)=plot(x_label, acc_LFC,'--ko','LineWidth',linewidth,'MarkerFaceColor','w','MarkerSize',MarkerSize);
    han(4,1)=plot(x_label, acc_PC,'-kx','LineWidth',linewidth,'MarkerFaceColor','w','MarkerSize',MarkerSize+2);
    han(5,1)=plot(x_label, acc_Soft_LCM,'-k','LineWidth',linewidth);
    le=legend(han(1:5),'MV-LFC','M3V-LFC','LC Model','PC Model','CS-LFC-SVM'); 
%     set(le,'YColor',[1 1 1],'XColor',[1 1 1]);
    set(le,'Box','off');
%     set(le,'FontSize',11)

    title(title_name,'FontSize',16)
    xlabel('# random annotators / # normal annotators','FontSize',16);
    ylabel('The test accuracy(%)','FontSize',16);
%     axis([0,10,0.6,1]);

    
%     accuracy_result = [acc_MV,acc_M3V,acc_LFC,acc_PC,acc_MV_Probability,acc_DS_Estimator,acc_Soft_LCM]
%     std_result=[std_MV,std_M3V,std_LFC,std_PC,std_MV_Probability,std_DS_Estimator,std_Soft_LCM]
%     file_name=sprintf('%s%s',output_file_dir,'plot_data.mat');
%     save(file_name,'*');
end

