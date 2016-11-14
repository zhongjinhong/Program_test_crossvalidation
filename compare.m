function [  ] = compare( experiment_num )

    Initialization();
    svm_para=sprintf('%s','-s 0 -t 0');
 
    for num=begin_num:end_num
        for repeat_num=1:total_repeat_num           
            file_name=sprintf('%s%s%d%s',input_file_dir,'X_',repeat_num,'.mat');
            load(file_name); 
            file_name=sprintf('%s%s%d%s',input_file_dir,'Y_',repeat_num,'.mat');
            load(file_name); 
            %%%%%%%% load the ground-truth labels %%%%%%%%%%%%%%%%
            file_name=sprintf('%s%s%d%s',input_file_dir,'Z_',repeat_num,'.mat');
            load(file_name); 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            index = find(sum(Y~=-2,2)>0);
            X = X(index,:);
            Y = Y(index,:);  
            Z = Z(index,:);
            [n,expert_num] = size(Y);
            switch experiment_num
                case {41,42,43,44}
                    Y_temp=Y;
                    for i = 1:num-1
                        Y = [Y Y_temp];
                    end              
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

            W_LCM1( (num-begin_num)*total_repeat_num+repeat_num,: ) =LCM(X,Y,svm_para);    
            W_LCM2( (num-begin_num)*total_repeat_num+repeat_num,: ) =LCM_compare(X,Y,svm_para);  

            
            for i=1:n
                for t=1:expert_num
                    if(Y(i,t)==-1)
                        Y(i,t)=0;
                    end
                end
            end
            
            
            tic
            W_MV_Probability( (num-begin_num)*total_repeat_num+repeat_num,: )=MV_Probability(X,Y,svm_para);
            Time_MV_Probability((num-begin_num)*total_repeat_num+repeat_num)= toc;
            tic
            W_DS_Estimator( (num-begin_num)*total_repeat_num+repeat_num,: )=DS_Estimator(X,Y,svm_para);
            Time_DS_Estimator ((num-begin_num)*total_repeat_num+repeat_num)= toc;            


            [n,d]=size(X);
            X(:,d+1)=1;d=d+1;  

            tic
            W_LFC( (num-begin_num)*total_repeat_num+repeat_num,: )=LFC(X,Y);
            Time_LFC( (num-begin_num)*total_repeat_num+repeat_num )= toc;
            tic
            W_PC( (num-begin_num)*total_repeat_num+repeat_num,: )=PC(X,Y);
            Time_PC ((num-begin_num)*total_repeat_num+repeat_num)= toc;

            
            dis_information=sprintf('%s%d  %s%d\n','num=',num,'repeat_num=',repeat_num);
            disp(dis_information);
            pause(1)


            
            
            
            
%             file_name=sprintf('%s%s',output_file_dir,'W_LFC.mat');
%             save(file_name,'W_LFC');
%             file_name=sprintf('%s%s',output_file_dir,'W_PC.mat');
%             save(file_name,'W_PC');
%             file_name=sprintf('%s%s',output_file_dir,'W_MV.mat');
%             save(file_name,'W_MV');
%             file_name=sprintf('%s%s',output_file_dir,'W_M3V.mat');
%             save(file_name,'W_M3V');      
%             file_name=sprintf('%s%s',output_file_dir,'W_LCM.mat');
%             save(file_name,'W_LCM');
% 
% 
%             file_name=sprintf('%s%s',output_file_dir,'W_MV_Probability.mat');
%             save(file_name,'W_MV_Probability');
%             file_name=sprintf('%s%s',output_file_dir,'W_DS_Estimator.mat');
%             save(file_name,'W_DS_Estimator');
% 
% 
%             count=count;
%             file_name=sprintf('%s%s',output_file_dir,'count.mat');
%             save(file_name,'count','-v7.3');
% 
%             file_name=sprintf('%s%s',output_file_dir,'Time.mat');
%             save(file_name,'Time_*');            
        
        
        end

        file_name=sprintf('%s%s',output_file_dir,'W_LFC.mat');
        save(file_name,'W_LFC');
        file_name=sprintf('%s%s',output_file_dir,'W_PC.mat');
        save(file_name,'W_PC');
        file_name=sprintf('%s%s',output_file_dir,'W_MV.mat');
        save(file_name,'W_MV');
        file_name=sprintf('%s%s',output_file_dir,'W_M3V.mat');
        save(file_name,'W_M3V');      
%         file_name=sprintf('%s%s',output_file_dir,'W_LCM.mat');
%         save(file_name,'W_LCM');
        
        file_name=sprintf('%s%s',output_file_dir,'W_LCM1.mat');
        save(file_name,'W_LCM1');
        file_name=sprintf('%s%s',output_file_dir,'W_LCM2.mat');
        save(file_name,'W_LCM2');        
        
        
        file_name=sprintf('%s%s',output_file_dir,'W_MV_Probability.mat');
        save(file_name,'W_MV_Probability');
        file_name=sprintf('%s%s',output_file_dir,'W_DS_Estimator.mat');
        save(file_name,'W_DS_Estimator');
        
        
%         count=count;
%         file_name=sprintf('%s%s',output_file_dir,'count.mat');
%         save(file_name,'count','-v7.3');

        file_name=sprintf('%s%s',output_file_dir,'Time.mat');
        save(file_name,'Time_*');


    end
end