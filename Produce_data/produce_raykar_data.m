function [  ] = produce_raykar_data( file_dir, data, label, labeled_num )

    alpha =[0.7;0.6;0.6;0.5;0.5;0.5;0.4;0.4;0.4;0.4];
    beta = [0.2;0.2;0.2;0.2;0.2;0.2;0.2;0.2;0.2;0.2];
    expert_num = size(alpha,1);
    K = 10;

    [n,d]=size(data);
    
    for repeat_num = 1:10
        
        rn=rand(n,expert_num);
        rn1=rand(n,expert_num);
        Y=zeros(n,expert_num);
        for i=1:n
            for t=1:expert_num
                if(rn(i,t) < alpha(t)+beta(t)*rn1(i,t))
                    Y(i,t) = label(i,1);
                else
                    Y(i,t) = -label(i,1);
                end            
            end 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             index = randperm(expert_num);
%             Y(i, index(labeled_num+1:end)) = -2;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
        end

        num = floor(0.9*n);
        for t=1:expert_num
            index = randperm(n);
            Y(index(1:num),t) = -2;          
        end 


        Indices = crossvalind('Kfold', n, K);
        Y_temp = Y;
        for k = 1:K
            train_index = find(Indices ~= k);
            test_index = find(Indices == k);

            X = data(train_index,:);
            Y = Y_temp(train_index,:);
            Z = label(train_index,:);

            X_test = data(test_index,:);
            Y_test = label(test_index,:);

            
            file_name=sprintf('%s%s%d%s',file_dir,'X_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'X');
            file_name=sprintf('%s%s%d%s',file_dir,'Y_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'Y');
            file_name=sprintf('%s%s%d%s',file_dir,'Z_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'Z');
            
            file_name=sprintf('%s%s%d%s',file_dir,'X_test_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'X_test');
            file_name=sprintf('%s%s%d%s',file_dir,'Y_test_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'Y_test');    
        end
        
    end

end