clear;
cluster_num = 20;
instances_num = 50;
expert_num = 5;
K = 10;
file_dir='../../Input Data/system_error/';
X = zeros(cluster_num*instances_num, 2);
Z = zeros(cluster_num*instances_num, 1);
cluster_index = zeros(cluster_num*instances_num, 1);

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
        if (X(i,1) >X(i,2) ) 
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
        cluster_index_temp = cluster_index(train_index,:);

        X_test = data(test_index,:);
        Y_test = label(test_index,:);

        Y_temp = [];
        for num = 1:expert_num
            Y_temp = [Y_temp Z];
        end

        Y = Y_temp;
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
            for t = 1:noisy_times*expert_num
                cluster_rand_index = randperm(cluster_num);
                for i = 1:train_num
                    cluster_point = find( cluster_rand_index==cluster_index_temp(i,1) );
                    if ( cluster_point<= cluster_num/2 )
                        Y(i,t) = Z(i,1);
                    else
                        Y(i,t) = -Z(i,1);
                    end             
                end
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

