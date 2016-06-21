function [  ] = adjusting_parameter( experiment_num )
    
    Initialization();
    

    file_name=sprintf('%s%s',input_file_dir,'X_test.mat');
    load(file_name);
    file_name=sprintf('%s%s',input_file_dir,'Y_test.mat');
    load(file_name);    
    [test_num, d]=size(X_test);
    X_test(:,d+1)=ones(test_num,1);
    predict_label = zeros(test_num,1);
    target=(0.5*Y_test+0.5)';
    accuracy = zeros(16, (end_num-begin_num+1) );
    auc = accuracy;
    
    
    for num=begin_num:end_num
        for repeat_num=1:total_repeat_num
            file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'X_',num*step_num,'_',repeat_num,'.mat');
            load(file_name);  
            file_name=sprintf('%s%s%d%s%d%s',input_file_dir,'Y_',num*step_num,'_',repeat_num,'.mat');
            load(file_name);             
 
            
            for para_num = 1:16
                svm_para = sprintf('%s%d','-s 0 -t 0 -c ',2^(para_num-6) );
                [W_LCM,count] = LCM_test(X,Y,svm_para);
                
                Result_LCM = 0;
                for i=1:test_num
                    predict_label(i,1)=W_LCM*X_test(i,:)';
                    if(predict_label(i,1)*Y_test(i)>0)
                        Result_LCM = Result_LCM + 1;
                    elseif(predict_label(i,1)*Y_test(i)==0)
                        Result_LCM = Result_LCM + 0.5;
                    end
                end
                [tpr,fpr] = roc(target,predict_label');
                point_num = size(tpr,2);
                if tpr(point_num)~=1 || fpr(point_num)~=1
                    tpr(1,point_num+1) = 1;
                    fpr(1,point_num+1) = 1;
                end
                AUC_LCM = trapz(fpr,tpr);
                Result_LCM = Result_LCM/test_num;    
                
                accuracy(para_num,num-begin_num+1) = accuracy(para_num,num-begin_num+1) + Result_LCM;
                auc(para_num,num-begin_num+1) = auc(para_num,num-begin_num+1) + AUC_LCM;
                
            end

            
            dis_information=sprintf('%s%d  %s%d\n','num=',num,'repeat_num=',repeat_num);
            disp(dis_information);
            pause(1)
        end
        

        
    end
    accuracy = accuracy/total_repeat_num;
    auc = auc/total_repeat_num;
    
    file_name=sprintf('%s%s',output_file_dir,'choose_svm_para.mat');
    save(file_name,'*');

    figure()
    hold on 
    for para_num = 1:16
        a = floor(para_num/4);
        b = mod(para_num, 4);
        switch a
            case 0
                type = '--+';
            case 1
                type = '--o';
            case 2
                type = '--*';
            case 3
                type = '-';
            case 4
                type = '-o';
        end
        switch b 
            case 0
                color = 'r';
            case 1
                color = 'g';
            case 2
                color = 'b';
            case 3
                color = 'c';
        end
        line_type = sprintf('%s%s',type,color);
        linewidth = 2;
        han(para_num, 1) = plot(1:end_num-begin_num+1, accuracy(para_num,:), line_type, 'LineWidth',linewidth,'MarkerFaceColor',color);
    end    
    legend(han(1:16),'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16');
    
    
    
    
    figure()
    hold on 
    for para_num = 1:16
        a = floor(para_num/4);
        b = mod(para_num, 4);
        switch a
            case 0
                type = '--+';
            case 1
                type = '--o';
            case 2
                type = '--*';
            case 3
                type = '-';
            case 4
                type = '-o';
        end
        switch b 
            case 0
                color = 'r';
            case 1
                color = 'g';
            case 2
                color = 'b';
            case 3
                color = 'c';
        end
        line_type = sprintf('%s%s',type,color);
        linewidth = 2;
        han(para_num, 1) = plot(1:end_num-begin_num+1, auc(para_num,:), line_type, 'LineWidth',linewidth,'MarkerFaceColor',color);
    end    
    legend(han(1:16),'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16');
    
    
    
end

