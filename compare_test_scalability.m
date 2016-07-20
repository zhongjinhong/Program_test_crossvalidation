function [  ] = compare_test_scalability( experiment_num )
    Initialization();
    svm_para=sprintf('%s','-s 0 -t 0');

 
    for num=begin_num:end_num
        for repeat_num=1:total_repeat_num
            switch experiment_num      
                case {45,46,47,48,49,50,51,52}
                    file_name=sprintf('%s%s%d%s',input_file_dir,'X_',repeat_num,'.mat');
                    load(file_name); 
                    file_name=sprintf('%s%s%d%s',input_file_dir,'Y_',repeat_num,'.mat');
                    load(file_name); 
                    
                    
                    [n,expert_num] = size(Y);
                    rn_temp = rand(n,expert_num*(num-1));
                    Y_temp = zeros(n,expert_num*(num-1));
                    
                    if experiment_num >= 49 && experiment_num <= 52
                        probability_temp = 0.8;
                    else
                        probability_temp = 0.5;
                    end

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
            end

            
            index = find(sum(Y~=-2,2)>0);
            X = X(index,:);
            Y = Y(index,:);              
            
            
            
            n=size(X,1);
            expert_num=size(Y,2);          
            
            
            
            tic
            W_MV( (num-begin_num)*total_repeat_num+repeat_num,: )=Majority_Method(X,Y,svm_para);            
            Time_MV ((num-begin_num)*total_repeat_num+repeat_num)= toc;           
            tic
            W_M3V( (num-begin_num)*total_repeat_num+repeat_num,: )=M3V(X,Y,svm_para);
            Time_M3V ((num-begin_num)*total_repeat_num+repeat_num)= toc;          
%             tic
%             [W_LCM( (num-begin_num)*total_repeat_num+repeat_num,: ),count( 1:2*n,(num-begin_num)*total_repeat_num+repeat_num )]=LCM_test_linear(X,Y,svm_para);
%             Time_Soft_LCM((num-begin_num)*total_repeat_num+repeat_num)= toc;

            tic
            W_LCM1( (num-begin_num)*total_repeat_num+repeat_num,: ) =LCM(X,Y,svm_para);    
            Time_Soft_LCM1((num-begin_num)*total_repeat_num+repeat_num)= toc;

            
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
            tic
            W_PC( (num-begin_num)*total_repeat_num+repeat_num,: )=PC(X,Y);
            Time_PC ((num-begin_num)*total_repeat_num+repeat_num)= toc;

            
            dis_information=sprintf('%s%d  %s%d\n','num=',num,'repeat_num=',repeat_num);
            disp(dis_information);
            pause(1)
        
        end

        file_name=sprintf('%s%s',output_file_dir,'W_LFC.mat');
        save(file_name,'W_LFC');
        file_name=sprintf('%s%s',output_file_dir,'W_PC.mat');
        save(file_name,'W_PC');
        file_name=sprintf('%s%s',output_file_dir,'W_MV.mat');
        save(file_name,'W_MV');
        file_name=sprintf('%s%s',output_file_dir,'W_M3V.mat');
        save(file_name,'W_M3V');      
        file_name=sprintf('%s%s',output_file_dir,'W_LCM1.mat');
        save(file_name,'W_LCM1');      
       
        

        file_name=sprintf('%s%s',output_file_dir,'Time.mat');
        save(file_name,'Time_*');


    end
end