clear;
cluster_num = 2;
instances_num = 100;
non_label_proba = 0.7;
bias = 2*rand(1,10)-1;
% bias = 20*rand(1,10);

bias = [0 bias];

% bias = (0:1:10)*4;

expert_num = 1;
K = 10;
file_dir='../../Input Data/system_error_new/';
X = zeros(cluster_num*instances_num, 2);
Z = zeros(cluster_num*instances_num, 1);

for repeat_num = 1:10
    miu = [1 1;-1 -1];
    for i = 1:cluster_num
        index = (i-1)*instances_num;
        for j = 1:instances_num
            X( index+j, :) = normrnd(miu(i,:),1);
        end
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

        Y=zeros(train_num, 1);
        for i = 1:train_num
            fx = sum(X(i,:),2);
            positive_proba = 1/( 1+exp(-fx-bias(1,1)) );
            if rand() < positive_proba
                Y(i,1) = 1;
            else
                Y(i,1) = -1;
            end            
        end
        Y_temp = Y;
        
        
        non_label_num = floor(non_label_proba*train_num);
        
        index = randperm(train_num);
        Y(index(1:non_label_num),1) = -2;          
        

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
            Y = zeros(train_num, noisy_times);
            for i = 1:train_num      
                fx = sum(X(i,:),2);
                for t = 1:noisy_times
                    positive_proba = 1/( 1+exp(-fx-bias(1,t+1)) );
                    if rand() < positive_proba
                        Y(i,t) = 1;
                    else
                        Y(i,t) = -1;
                    end                    
                end
            end

            Y = [Y_temp Y];
            
            for t = 1:noisy_times+1
                index = randperm(train_num);
                Y(index(1:non_label_num),t) = -2;  
            end           
            
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
        
        
%         
%         accuracy = zeros(noisy_times+1, 1);
%         for t = 1:noisy_times+1
%             for i = 1:train_num
%                 if Y(i,t) == Z(i,1)
%                     accuracy(t,1)=accuracy(t,1) + 1;
%                 end
%             end
%             accuracy(t,1) = accuracy(t,1)/train_num;
%         end    
%         bias=bias';
        
        
    end
end

