function [  ] = handle_time( experiment_num, type )
    Initialization();
    if type == 1
        data = zeros(4,7);
        for k = 1:6
            switch k
                case 1
                    file_name='../Output Data/Adult/Clustering/Time.mat';
                case 2
                    file_name='../Output Data/Conect/Clustering/Time.mat';
                case 3
                    file_name='../Output Data/mushroom/Clustering/Time.mat';
                case 4
                    file_name='../Output Data/test_data/Clustering/Time.mat';
                case 5
                    file_name='../Output Data/Real Data/Clustering/Time.mat';
                case 6
                    file_name='../Output Data/Real_Data_AAAI_balance/Clustering/Time.mat';
            end  
            load(file_name);

            data(k,1) = mean(Time_MV);
            data(k,2) = mean(Time_M3V);
            data(k,3) = mean(Time_LFC);
            data(k,4) = mean(Time_PC); 
%             data(k,5) = mean(Time_MV_Probability);
%             data(k,6) = mean(Time_DS_Estimator);
            data(k,5) = mean(Time_Soft_LCM);        
        end

        bar(data);
        name = {'Adult', 'Conect', 'Mushroom', 'DNA','Twitter Topic','Twitter NER'};
        legend('MV-LFC','M3V-LFC','LC Model','PC Model','CS-LFC');
        set(gca, 'XTickLabel', name);
        set(gca, 'FontSize', 12);
        set(gca, 'YScale','log');
        colormap('Jet')
        
        title('Time comparision','FontSize',16)
        xlabel('Data Set','FontSize',16);
        ylabel('Runing time(s)','FontSize',16);
  
        
    else
        file_name=sprintf('%s%s',output_file_dir,'Time.mat');
        load(file_name);
        
        n=size(Time_Soft_LCM,2);
        n=n/total_repeat_num;
        for i=1:n
            time_LFC(i)=mean(Time_LFC( (i-1)*total_repeat_num+1:i*total_repeat_num));
            time_PC(i)=mean(Time_PC( (i-1)*total_repeat_num+1:i*total_repeat_num));
            time_MV(i)=mean(Time_MV( (i-1)*total_repeat_num+1:i*total_repeat_num));
            time_M3V(i)=mean(Time_M3V( (i-1)*total_repeat_num+1:i*total_repeat_num)); 
            time_Soft_LCM(i)=mean( Time_Soft_LCM( (i-1)*total_repeat_num+1:i*total_repeat_num) );
            time_MV_Probability(i)=mean(Time_MV_Probability( (i-1)*total_repeat_num+1:i*total_repeat_num));
            time_DS_Estimator(i)=mean(Time_DS_Estimator( (i-1)*total_repeat_num+1:i*total_repeat_num));
        end
        x_label = 5:5:55;
        linewidth = 2;
        figure();
        hold on
        han(1,1)=plot(x_label, time_MV,'-cs','LineWidth',linewidth,'MarkerFaceColor','c');
        han(2,1)=plot(x_label, time_M3V,'-ks','LineWidth',linewidth,'MarkerFaceColor','k');
        han(3,1)=plot(x_label, time_LFC,'-gs','LineWidth',linewidth,'MarkerFaceColor','g');
        han(4,1)=plot(x_label, time_PC,'-bs','LineWidth',linewidth,'MarkerFaceColor','b');
%         han(5,1)=plot(x_label, time_MV_Probability,'--m+','LineWidth',linewidth,'MarkerFaceColor','m');
%         han(6,1)=plot(x_label, time_DS_Estimator,':mx','LineWidth',linewidth,'MarkerFaceColor','m');
        han(5,1)=plot(x_label, time_Soft_LCM,'-rs','LineWidth',linewidth,'MarkerFaceColor','r');
        legend(han(1:5),'MV-LFC','M3V-LFC','LC Model','PC Model','CS-LFC');      

%         title(title_name,'FontSize',16)
        xlabel('The annotator number','FontSize',16);
        ylabel('The computing time (s)','FontSize',16);
        
        figure();
        hold on
        han(1,1)=plot(x_label, time_MV,'-cs','LineWidth',linewidth,'MarkerFaceColor','c');
        han(2,1)=plot(x_label, time_M3V,'-ks','LineWidth',linewidth,'MarkerFaceColor','k');
        han(3,1)=plot(x_label, time_LFC,'-gs','LineWidth',linewidth,'MarkerFaceColor','g');
        han(4,1)=plot(x_label, time_Soft_LCM,'-rs','LineWidth',linewidth,'MarkerFaceColor','r');
        legend(han(1:4),'MV-LFC','M3V-LFC','LC Model','CS-LFC');             
        xlabel('The annotator number','FontSize',16);
        ylabel('The computing time (s)','FontSize',16);    
        
        
        figure();
        hold on
        han(1,1)=plot(x_label, time_MV,'-cs','LineWidth',linewidth,'MarkerFaceColor','c');
        han(2,1)=plot(x_label, time_M3V,'-ks','LineWidth',linewidth,'MarkerFaceColor','k');
        legend(han(1:2),'MV-LFC','M3V-LFC');             
        xlabel('The annotator number','FontSize',16);
        ylabel('The computing time (s)','FontSize',16);          
        
        
        
    end
            

end

