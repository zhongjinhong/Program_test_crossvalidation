function [  ] = handle_time( type )
%     Initialization();
%     data = zeros(4,7);
    set(0,'defaultfigurecolor','w')
    if type <= 3
        switch type
            case 1
                data_type = 'Clustering/';
                title_name = 'Clustering data';
            case 2
                data_type = 'latent model/';
                title_name = 'Raykar''s data';
            case 3
                data_type = 'expertise_difficult_model/';
                title_name = 'Whitehill''s data';
            case 4
                data_type = 'Real Label/';  
                title_name = 'Crowdsourcing';
        end

        for k = 1:6
            switch k
                case 1
                    dataset='Adult/';
                case 2
                    dataset='Conect/';
                case 3
                    dataset='mushroom/';
                case 4
                    dataset='test_data/';
                case 5
                    dataset='Real Data/';
                case 6
                    dataset='Real_Data_AAAI_balance/';
            end  

            file_name = sprintf('%s%s%s%s','../Output Data/',dataset,data_type,'Time.mat');     

            load(file_name);

            data(k,1) = mean(Time_MV);
            data(k,2) = mean(Time_M3V);
            data(k,3) = mean(Time_LFC);
            data(k,4) = mean(Time_PC); 
            data(k,5) = mean(Time_Soft_LCM);        
        end

        bar(data,'BaseValue',0.001);
        name = {'Adult', 'Conect', 'Mushroom', 'DNA','Twitter Topic','Twitter NER'};
        l=legend('MV-LFC','M3V-LFC','LC Model','PC Model','CS-LFC');
        set(l,'YColor',[1 1 1],'XColor',[1 1 1]);
%         set(l,'Box','off');
        set(gca, 'XTickLabel', name);
        set(gca, 'FontSize', 12);
        set(gca, 'YScale','log');
        set(gca,'color','w')
        colormap('Jet')

        title(title_name,'FontSize',16)
%         xlabel('Data Set','FontSize',16);
        ylabel('Runing time(s)','FontSize',16);
    end
    
    if type == 4
        data_type = 'Real Label/'; 
        title_name = 'Crowdsourcing';
        for k = 1:2
            switch k
                case 1
                    dataset='Real Data/';
                case 2
                    dataset='Real_Data_AAAI_balance/';
            end  

            file_name = sprintf('%s%s%s%s','../Output Data/',dataset,data_type,'Time.mat');     

            load(file_name);

            data(k,1) = mean(Time_MV);
            data(k,2) = mean(Time_M3V);
            data(k,3) = mean(Time_LFC);
            data(k,4) = mean(Time_PC); 
            data(k,5) = mean(Time_Soft_LCM);        
        end

       bar(data,'BaseValue',0.001);
        name = {'Adult', 'Conect', 'Mushroom', 'DNA','Twitter Topic','Twitter NER'};
        l=legend('MV-LFC','M3V-LFC','LC Model','PC Model','CS-LFC');
        set(l,'YColor',[1 1 1],'XColor',[1 1 1]);
%         set(0,'defaultfigurecolor','w')
%         set(l,'Box','off');
        set(gca, 'XTickLabel', name);
        set(gca, 'FontSize', 12);
        set(gca, 'YScale','log');
        set(gca,'color','w')
        colormap('Jet')

        title(title_name,'FontSize',16)
        xlabel('Data Set','FontSize',16);
        ylabel('Runing time(s)','FontSize',16);      
    end
%  applyhatch(gcf,'/.\+x');
end