clear;
cluster_num = 20;
instances_num = 50;
expert_num = 3;
K = 10;
file_dir='../../Input Data/system_error_new2/';
X = zeros(cluster_num*instances_num, 2);
Z = zeros(cluster_num*instances_num, 1);
cluster_index = zeros(cluster_num*instances_num, 1);

non_label_proba = 0.7;
error_label_proba = 0.3;
bias_miu = zeros([expert_num*10, 2]);
for t = 1:expert_num*10
    bias_miu(t,:) = normrnd([0, 0],0.5);
end



for repeat_num = 1:10
    
    miu = 2*rand(cluster_num,2)-1;
    for i = 1:cluster_num
        index = (i-1)*instances_num;
        for j = 1:instances_num
            X( index+j, :) = normrnd(miu(i,:),1);
        end
        cluster_index(index+1:index+instances_num,1) = i;
    end


    for i = 1:cluster_num*instances_num
        if (sum(X(i,:),2)>=0 ) 
            Z(i,1) = 1;
        else
            Z(i,1) = -1;
        end
    end
    data = X;
    label = Z;

    
    Indices = crossvalind('Kfold', cluster_num*instances_num, K);
    for k = 1:K
        train_index = find(Indices ~= k);
        test_index = find(Indices == k);
        train_num = size(train_index,1);

        X = data(train_index,:);
        Z = label(train_index,:);


        X_test = data(test_index,:);
        Y_test = label(test_index,:);

        Y=zeros(train_num, expert_num);
        non_label_num = floor(non_label_proba*train_num);
        for i = 1:train_num
            for t = 1:expert_num
                if rand() < error_label_proba
                    Y(i,t) = -Z(i,1);
                else
                    Y(i,t) = Z(i,1);
                end                
            end
          
        end
        
        
        for t=1:expert_num
            index = randperm(train_num);
            Y_temp(index(1:non_label_num),t) = -2;          
        end             
        Y_temp = Y;
        


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
        

        
        for noisy_times = 1:10
            Y = zeros(train_num, noisy_times*expert_num);
            for i = 1:train_num      
                for t = 1:noisy_times*expert_num
                    fx = norm(X(i,:)-bias_miu(t,:),2);
                    positive_proba = 1/( 1+exp(-fx) );
                    if rand() < positive_proba
                        Y(i,t) = 1;
                    else
                        Y(i,t) = -1;
                    end                    
                end
            end
            
            for t = 1:noisy_times*expert_num
                index = randperm(train_num);
                Y(index(1:non_label_num),t) = -2;  
            end   
            Y = [Y_temp Y];
            

            file_name=sprintf('%s%s%d%s',file_dir,'X_',noisy_times*100+(repeat_num-1)*10+k,'.mat');
            save(file_name,'X');
            file_name=sprintf('%s%s%d%s',file_dir,'Y_',noisy_times*100+(repeat_num-1)*10+k,'.mat');
            save(file_name,'Y');
            file_name=sprintf('%s%s%d%s',file_dir,'Z_',noisy_times*100+(repeat_num-1)*10+k,'.mat');
            save(file_name,'Z');
            file_name=sprintf('%s%s%d%s',file_dir,'X_test_',noisy_times*100+(repeat_num-1)*10+k,'.mat');
            save(file_name,'X_test');
            file_name=sprintf('%s%s%d%s',file_dir,'Y_test_',noisy_times*100+(repeat_num-1)*10+k,'.mat');
            save(file_name,'Y_test');            
        end
    end
end

