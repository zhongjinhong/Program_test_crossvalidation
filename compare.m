function [  ] = compare( experiment_num )
    addpath('tools/');
    Initialization();
    svm_para=sprintf('%s','-s 0 -t 0');
    

    if experiment_num==24 || experiment_num==28 || experiment_num==29|| experiment_num==30|| experiment_num==31 || experiment_num==40
        mini_annotator = 0;
    else
        mini_annotator = 2;
    end
    
    if experiment_num==28
        write_step = 1;
    else
        write_step = 10;
    end
    

    
    
    for num=begin_num:end_num
        for repeat_num=1:total_repeat_num   
%     for num=end_num:end_num        
%         for repeat_num=total_repeat_num-10:total_repeat_num    
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             total_repeat_num = 20;
%             num = 11;
%             repeat_num = 79;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            
            if experiment_num==30||31||40
                file_name=sprintf('%s%s%d%s',input_file_dir,'X_',(num-1)*total_repeat_num+repeat_num,'.mat');
                load(file_name); 
                file_name=sprintf('%s%s%d%s',input_file_dir,'Y_',(num-1)*total_repeat_num+repeat_num,'.mat');
                load(file_name); 
                %%%%%%%% load the ground-truth labels %%%%%%%%%%%%%%%%
                file_name=sprintf('%s%s%d%s',input_file_dir,'Z_',(num-1)*total_repeat_num+repeat_num,'.mat');
                load(file_name); 
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                    
            else
                file_name=sprintf('%s%s%d%s',input_file_dir,'X_',repeat_num,'.mat');
                load(file_name); 
                file_name=sprintf('%s%s%d%s',input_file_dir,'Y_',repeat_num,'.mat');
                load(file_name); 
                %%%%%%%% load the ground-truth labels %%%%%%%%%%%%%%%%
                file_name=sprintf('%s%s%d%s',input_file_dir,'Z_',repeat_num,'.mat');
                load(file_name); 
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
            end
            index = find(sum(Y~=-2,2)>mini_annotator);
            X = X(index,:);
            Y = Y(index,:);  
            Z = Z(index,:);
            [n,expert_num] = size(Y);
            switch experiment_num
%                 case {41,42,43,44}
%                     file_name=sprintf('%s%s%d%s',input_file_dir,'true_label_',repeat_num,'.mat');
%                     load(file_name); 
%                     train_label = train_label(index,:);
%                     Idx = zeros(n,1);
%                     index = find(train_label == 1);
%                     Idx(index,1) = 1;
%                     index = find(train_label == 2);
%                     Idx(index,1) = 2;
%                     index = find(train_label == 4);
%                     Idx(index,1) = 3;
% 
%                     index = find(train_label == 3);
%                     job_num = size(index,1);
%                     index1 = randperm(job_num);
%                     instance_num = floor(job_num/3);
%                     Idx( index(index1(1:instance_num)),1 ) = 4;
%                     Idx( index(index1(instance_num+1:instance_num*2)),1 ) = 5;
%                     Idx( index(index1(instance_num*2+1:end)),1 ) = 6;  
%                     
%                     Y_temp = zeros(n,expert_num*(num-1));
%                     for t = 1:expert_num*(num-1)
%                         topic_idx = randperm(6);
%                         Y_temp(:,t) = Z;
%                         for i = 1:n
%                             if(Idx(i,1)==topic_idx(1)||Idx(i,1)==topic_idx(2))
%                                 Y_temp(i,t)= -Y_temp(i,t);
%                             end
%                         end
%                     end
% 
%                     Y = [Y Y_temp];                                
                case {45,46,47,48}
                    rn_temp = rand(n,expert_num*(num-1));
                    Y_temp = zeros(n,expert_num*(num-1));
                    probability_temp = 0.5;
                    for i=1:n
                        for t=1:expert_num*(num-1)
                            if(rn_temp(i,t)< probability_temp)
                                Y_temp(i,t)= 1;
                            else
                                Y_temp(i,t)= -1;
                            end
                        end 
                    end  

                    Y = [Y Y_temp];

                case {49,50,51,52}
                    Y_temp = zeros(n,expert_num*(num-1));
                    
                    index = randperm(n);
                    X = X(index,:);
                    Y = Y(index,:);  
                    Z = Z(index,:);   
                    
                    wrong_num = floor(n/2);

                    for t=1:expert_num*(num-1)
                        Y_temp(:,t) = Z;
                        Y_temp(1:wrong_num,t) = - Y_temp(1:wrong_num,t);
                    end  

                    Y = [Y Y_temp];     
            end
            
            [n,expert_num] = size(Y);

            if experiment_num == 28
                filtered_annotator =[3 7 15 18 47 58 63 66 68 69 75 80 93 111 151 153 158 159 184 193 194 201 204 210 229];
                filter_num = size(filtered_annotator,2);
                for j = 1:filter_num
                    t = filtered_annotator(j);
                    for i = 1:n
                        if Y(i,t) ~= -2
                            if(rand()>0.5)
                                Y(i,t) = 1;
                            else
                                Y(i,t) = -1;
                            end
                        end
                    end
                end  
            end            
            
            
            
            tic
            W_MV( (num-begin_num)*total_repeat_num+repeat_num,: )=Majority_Method(X,Y,svm_para);            
            Time_MV ((num-begin_num)*total_repeat_num+repeat_num)= toc;           
            tic
            W_M3V( (num-begin_num)*total_repeat_num+repeat_num,: )=M3V(X,Y,svm_para);
            Time_M3V ((num-begin_num)*total_repeat_num+repeat_num)= toc;          

            
            tic
            [W_LCM( (num-begin_num)*total_repeat_num+repeat_num,: ),weight]=LCM_test_binary(X,Y,svm_para);
            Time_LCM ((num-begin_num)*total_repeat_num+repeat_num)= toc;   
          
            for i=1:n
                for t=1:expert_num
                    if(Y(i,t)==-1)
                        Y(i,t)=0;
                    end
                end
            end
            

            [n,d]=size(X);
            X(:,d+1)=1;d=d+1;  

       
            tic
            W_LFC( (num-begin_num)*total_repeat_num+repeat_num,: )=LFC(X,Y);
            Time_LFC( (num-begin_num)*total_repeat_num+repeat_num )= toc;
%             tic
%             W_PC( (num-begin_num)*total_repeat_num+repeat_num,: )=PC(X,Y);
%             Time_PC ((num-begin_num)*total_repeat_num+repeat_num)= toc;



            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            tic
            W_PC = W_MV;
            Time_PC ((num-begin_num)*total_repeat_num+repeat_num)= toc;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
            
            
            dis_information=sprintf('%s%d  %s%d\n','num=',num,'repeat_num=',repeat_num);
            disp(dis_information);
            pause(1)


            if mod(repeat_num,write_step)==0          
                file_name=sprintf('%s%s',output_file_dir,'W_LFC.mat');
                save(file_name,'W_LFC');
                file_name=sprintf('%s%s',output_file_dir,'W_PC.mat');
                save(file_name,'W_PC');
                file_name=sprintf('%s%s',output_file_dir,'W_MV.mat');
                save(file_name,'W_MV');
                file_name=sprintf('%s%s',output_file_dir,'W_M3V.mat');
                save(file_name,'W_M3V');      
                file_name=sprintf('%s%s',output_file_dir,'W_LCM.mat');
                save(file_name,'W_LCM');
            
                file_name=sprintf('%s%s',output_file_dir,'Time.mat');
                save(file_name,'Time_*');       
            end
        
        end


    end
end