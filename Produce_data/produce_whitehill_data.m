function [  ] = produce_whitehill_data( file_dir, data, label, labeled_num )

    expert_num=10;
    K = 10;
    [n,d]=size(data);
    
    for repeat_num = 1:10
    
        rn=rand(n,expert_num);
        Y=zeros(n,expert_num);
        alpha = normrnd(1,1,expert_num,1);
        beta = normrnd(1,1,n,1);

        P=zeros(n,expert_num);
        for t = 1:expert_num
            for i = 1:n
                P(i,t) = 1/(1+exp(-alpha(t)*beta(i)));
            end
        end 

        for i=1:n
            for t=1:expert_num
                if(rn(i,t)<P(i,t))
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

        num = floor(0.7*n);

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