function [  ] = produce_real_data_topic( file_dir, data, label, Y, train_label )
   
    [n,expert_num]=size(Y);
    K = 10;
    Y_temp = Y;
    train_label_temp = train_label;
    for repeat_num = 1:10
        Indices = crossvalind('Kfold', n, K);
        
        for k = 1:K
            train_index = find(Indices ~= k);
            test_index = find(Indices == k);

            X = data(train_index,:);
            Y = Y_temp(train_index,:);
            Z = label(train_index,:);
            train_label = train_label_temp(train_index,:);

            X_test = data(test_index,:);
            Y_test = label(test_index,:);

            
            
            file_name=sprintf('%s%s%d%s',file_dir,'X_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'X');
            file_name=sprintf('%s%s%d%s',file_dir,'Y_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'Y');
            file_name=sprintf('%s%s%d%s',file_dir,'Z_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'Z');
            file_name=sprintf('%s%s%d%s',file_dir,'true_label_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'train_label');
            
            
            file_name=sprintf('%s%s%d%s',file_dir,'X_test_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'X_test');
            file_name=sprintf('%s%s%d%s',file_dir,'Y_test_',(repeat_num-1)*10+k,'.mat');
            save(file_name,'Y_test');    
        end

    end

end