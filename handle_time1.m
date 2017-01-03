function [  ] = handle_time1( dataset )
%     Initialization();
%     data = zeros(4,7);
    set(0,'defaultfigurecolor','w')
    switch dataset
        case 1
            dataset_dir='Adult/';
            title_name = 'Adult';
        case 2
            dataset_dir='Conect/';
            title_name = 'Conect';
        case 3
            dataset_dir='mushroom/';
            title_name = 'Mushroom';
        case 4
            dataset_dir='test_data/';
            title_name = 'DNA';
        case 5
            dataset_dir='Real Data/';
            title_name = 'Twitter Topic';
        case 6
            dataset_dir='Real_Data_AAAI_balance/';
            title_name = 'Twitter NER';
    end
    end_num = 3;
    name = {'Clustering data', 'Raykar''s data', 'Whitehill''s data'};
    if dataset >= 5
        end_num = 4;
        name = {'Clustering data', 'Raykar''s data', 'Whitehill''s data', 'Real label'};
    end
    for type = 1:end_num
        switch type
            case 1
                data_type = 'Clustering/';
            case 2
                data_type = 'latent model/';
            case 3
                data_type = 'expertise_difficult_model/';
            case 4
                data_type = 'Real Label/';  
        end 
        
        file_name = sprintf('%s%s%s%s','../Output Data/',dataset_dir,data_type,'Time.mat');
        load(file_name);
        data(type,1) = mean(Time_MV);
        data(type,2) = mean(Time_M3V);
        data(type,3) = mean(Time_LFC);
        data(type,4) = mean(Time_PC); 
        data(type,5) = mean(Time_LCM);
    end
   

    bar(data,'BaseValue',0.001);
    l=legend('MV-LFC','M3V-LFC','LC Model','PC Model','QS-LFC-SVM');
    legend('boxoff')

    set(gca, 'XTickLabel', name);
    set(gca, 'FontSize', 12);
    set(gca, 'YScale','log');
    set(gca,'color','w')
    colormap('Jet')

    title(title_name,'FontSize',16)
    ylabel('Runing time(s)','FontSize',16);

%  applyhatch(gcf,'/.\+x');
end