function [  ] = produce_yanyan_data_topic( file_dir, data, label, train_label)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cluster_num = 5;
    expert_num = cluster_num*2;
    K = 10;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [n,d]=size(data);
    
    train_label_temp = train_label;
    for repeat_num = 1:10
        [Idx,C]=kmeans(data,cluster_num);
        [temp,C_temp]=kmeans(data,cluster_num);
        Idx(:,2)=temp+cluster_num;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        rn=rand(n,expert_num);
        rn1=rand(n,expert_num);
        rn2=rand(n,expert_num);

        Y=zeros(n,expert_num);
        for i=1:n
            for t=1:expert_num
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if(Idx(i,1)~=t&&Idx(i,2)~=t)
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    if(rn(i,t)< 0.5 + 0.1*rn1(i,t))
                        Y(i,t)= label(i,1);
                    else
                        Y(i,t)= -label(i,1);
                    end
                else
                    if(rn(i,t)< 0.9 + 0.1*rn2(i,t))
                        Y(i,t)=label(i,1);
                    else
                        Y(i,t)=-label(i,1);
                    end            
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