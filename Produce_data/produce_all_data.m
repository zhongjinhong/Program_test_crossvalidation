function [  ] = produce_all_data( data_num, experiment_num)
	labeled_num = 5;
    switch data_num
        case 1
            load 'Adult/Adult.mat';   
            data_string = 'Adult/';
        case 2
            load 'Conect/conect-4.mat';
            data_string = 'Conect/';
        case 3
            load 'mushroom/mushroom.mat';
            data_string = 'mushroom/';
        case 4
            load 'Real Data/realdata2.mat';
            data_string = 'Real Data/';
        case 5
            load 'test_data/dna.mat';
            data_string = 'test_data/';
%         case 6
%             load 'tiantian/tiantian.mat';
%             data_string = 'tiantian/';
%         case 7
%             load 'Real_Data_AAAI/real_data_aaai.mat';
%             data_string = 'Real_Data_AAAI/';
        case 8
            load 'Real_Data_AAAI_balance/real_data_aaai_balance.mat';
            data_string = 'Real_Data_AAAI_balance/';
            
        case 11
            load 'Real Data/realdata1.mat';
            data_string = 'Real Data/';
    end
    
    
    switch experiment_num
        case 1
            file_dir = sprintf('%s%s',data_string,'expertise_difficult_model/');
            produce_whitehill_data(file_dir, data, label, labeled_num);
        case 2
            file_dir = sprintf('%s%s',data_string,'latent model/');
            produce_raykar_data(file_dir, data, label, labeled_num);
        case 3
            file_dir = sprintf('%s%s',data_string,'Clustering/');
            produce_yanyan_data(file_dir, data, label, labeled_num);
        case 4
            file_dir = sprintf('%s%s',data_string,'Real Label/');
            produce_real_data(file_dir, data, label, Y);
    end

end

