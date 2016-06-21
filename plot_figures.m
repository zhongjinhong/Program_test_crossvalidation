function [  ] = plot_figures( experiment_num, plot_flag )

    Initialization();
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% debug %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    total_repeat_num=10;begin_num=1;end_num=3;step_num = 100;count=zeros(2*end_num*step_num,total_repeat_num); 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% debug %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    if experiment_num ~= 11
        if experiment_num ~= 10
            file_name=sprintf('%s%s',output_file_dir,'plot_data.mat');
            load(file_name);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% debug %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             total_repeat_num=10;begin_num=1;end_num=3;step_num = 100;count=zeros(2*end_num*step_num,total_repeat_num); 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% debug %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            figure();
            hold on;
            linewidth=2;
            x_label=(begin_num:end_num)*step_num;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% change figures %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             x_label=(begin_num+1:2:end_num)*step_num;
%             acc_LFC=acc_LFC(2:2:end);
%             acc_PC=acc_PC(2:2:end);
%             acc_MV=acc_MV(2:2:end);
%             acc_M3V=acc_M3V(2:2:end);
%             acc_Soft_LCM=acc_Soft_LCM(2:2:end);
%             acc_MV_Probability=acc_MV_Probability(2:2:end);
%             acc_DS_Estimator=acc_DS_Estimator(2:2:end);
%             auc_LFC=auc_LFC(2:2:end);
%             auc_PC=auc_PC(2:2:end);
%             auc_MV=auc_MV(2:2:end);
%             auc_M3V=auc_M3V(2:2:end);
%             auc_Soft_LCM=auc_Soft_LCM(2:2:end);
%             auc_MV_Probability=auc_MV_Probability(2:2:end);
%             auc_DS_Estimator=auc_DS_Estimator(2:2:end);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            han(1,1)=plot(x_label, acc_LFC,'-gs','LineWidth',linewidth,'MarkerFaceColor','g');
            han(2,1)=plot(x_label, acc_PC,'-bs','LineWidth',linewidth,'MarkerFaceColor','b');
            han(3,1)=plot(x_label, acc_MV,'-cs','LineWidth',linewidth,'MarkerFaceColor','c');

    % %         han(4,1)=plot(x_label,acc_YAN,'-ys','LineWidth',linewidth,'MarkerFaceColor','y');
            han(4,1)=plot(x_label, acc_M3V,'-ks','LineWidth',linewidth,'MarkerFaceColor','k');
            han(5,1)=plot(x_label, acc_Soft_LCM,'-rs','LineWidth',linewidth,'MarkerFaceColor','r');
            title(title_name,'FontSize',16)
            xlabel('The instance number','FontSize',16);
            ylabel('The test accuracy(%)','FontSize',16);
            
            if plot_flag == 1
                legend(han(1:5),'Raykar''s Model','Kajino''s Model','Majority Voting','M3V','Cost-sensitive');
            else
                han(6,1)=plot(x_label, acc_MV_Probability,'--m+','LineWidth',linewidth,'MarkerFaceColor','m');
                han(7,1)=plot(x_label, acc_DS_Estimator,':mx','LineWidth',linewidth,'MarkerFaceColor','m');
                legend(han(1:7),'Raykar''s Model','Kajino''s Model','Majority Voting','M3V','Cost-sensitive','MV Probability','DS Estimator');
            end
            
            
            xmin=min(x_label);
            xmax=max(x_label);
            xlim([xmin,xmax])

            figure();
            hold on;
            linewidth=2;
            han(1,1)=plot(x_label, auc_LFC,'-gs','LineWidth',linewidth,'MarkerFaceColor','g');
            han(2,1)=plot(x_label, auc_PC,'-bs','LineWidth',linewidth,'MarkerFaceColor','b');
            han(3,1)=plot(x_label, auc_MV,'-cs','LineWidth',linewidth,'MarkerFaceColor','c');

    %         han(5,1)=plot(auc_ABEL,'-ks','LineWidth',linewidth,'MarkerFaceColor','k'); 
    %         han(6,1)=plot(auc_DCS_LA,'-ys','LineWidth',linewidth,'MarkerFaceColor','y'); 
    %         han(4,1)=plot(x_label, auc_YAN,'-ys','LineWidth',linewidth,'MarkerFaceColor','y'); 
            han(4,1)=plot(x_label, auc_M3V,'-ks','LineWidth',linewidth,'MarkerFaceColor','k');
            han(5,1)=plot(x_label, auc_Soft_LCM,'-rs','LineWidth',linewidth,'MarkerFaceColor','r');
            title(title_name,'FontSize',16)
            xlabel('The instance number','FontSize',16);
            ylabel('The AUC','FontSize',16);

            if plot_flag == 1
                legend(han(1:5),'Raykar''s Model','Kajino''s Model','Majority Voting','M3V','Cost-sensitive');
            else
                han(6,1)=plot(x_label, auc_MV_Probability,'--m+','LineWidth',linewidth,'MarkerFaceColor','m');
                han(7,1)=plot(x_label, auc_DS_Estimator,':mx','LineWidth',linewidth,'MarkerFaceColor','m');
                legend(han(1:7),'Raykar''s Model','Kajino''s Model','Majority Voting','M3V','Cost-sensitive','MV Probability','DS Estimator');
            end

            xlim([xmin,xmax])
        else
            file_name=sprintf('%s%s',output_file_dir,'plot_data.mat');
            load(file_name);

            figure();
            hold on;
            linewidth=2;
            x_label=((begin_num:end_num)-1)*step_num;
            han(1,1)=plot(x_label, acc_LFC,'-gs','LineWidth',linewidth,'MarkerFaceColor','g');
            han(2,1)=plot(x_label, acc_PC,'-bs','LineWidth',linewidth,'MarkerFaceColor','b');
            han(3,1)=plot(x_label, acc_MV,'-cs','LineWidth',linewidth,'MarkerFaceColor','c');

    % %         han(4,1)=plot(x_label,acc_YAN,'-ys','LineWidth',linewidth,'MarkerFaceColor','y');
            han(4,1)=plot(x_label, acc_M3V,'-ks','LineWidth',linewidth,'MarkerFaceColor','k');
            han(5,1)=plot(x_label, acc_Soft_LCM,'-rs','LineWidth',linewidth,'MarkerFaceColor','r');
            title(title_name,'FontSize',16)
            xlabel('The number of noisy annotators','FontSize',16);
            ylabel('The test accuracy(%)','FontSize',16);
            if plot_flag == 1
                legend(han(1:5),'Raykar''s Model','Kajino''s Model','Majority Voting','M3V','Cost-sensitive');
            else
                han(6,1)=plot(x_label, acc_MV_Probability,'--m+','LineWidth',linewidth,'MarkerFaceColor','m');
                han(7,1)=plot(x_label, acc_DS_Estimator,':mx','LineWidth',linewidth,'MarkerFaceColor','m');
                legend(han(1:7),'Raykar''s Model','Kajino''s Model','Majority Voting','M3V','Cost-sensitive','MV Probability','DS Estimator');
            end

            figure();
            hold on;
            linewidth=2;
            han(1,1)=plot(x_label, auc_LFC,'-gs','LineWidth',linewidth,'MarkerFaceColor','g');
            han(2,1)=plot(x_label, auc_PC,'-bs','LineWidth',linewidth,'MarkerFaceColor','b');
            han(3,1)=plot(x_label, auc_MV,'-cs','LineWidth',linewidth,'MarkerFaceColor','c');

    %         han(5,1)=plot(auc_ABEL,'-ks','LineWidth',linewidth,'MarkerFaceColor','k'); 
    %         han(6,1)=plot(auc_DCS_LA,'-ys','LineWidth',linewidth,'MarkerFaceColor','y'); 
    %         han(4,1)=plot(x_label, auc_YAN,'-ys','LineWidth',linewidth,'MarkerFaceColor','y'); 
            han(4,1)=plot(x_label, auc_M3V,'-ks','LineWidth',linewidth,'MarkerFaceColor','k');
            han(5,1)=plot(x_label, auc_Soft_LCM,'-rs','LineWidth',linewidth,'MarkerFaceColor','r');
            title(title_name,'FontSize',16)
            xlabel('The number of noisy annotators','FontSize',16);
            ylabel('The AUC','FontSize',16);
            if plot_flag == 1
                legend(han(1:5),'Raykar''s Model','Kajino''s Model','Majority Voting','M3V','Cost-sensitive');
            else
                han(6,1)=plot(x_label, acc_MV_Probability,'--m+','LineWidth',linewidth,'MarkerFaceColor','m');
                han(7,1)=plot(x_label, acc_DS_Estimator,':mx','LineWidth',linewidth,'MarkerFaceColor','m');
                legend(han(1:7),'Raykar''s Model','Kajino''s Model','Majority Voting','M3V','Cost-sensitive','MV Probability','DS Estimator');
            end
        end
    else
        file_name=sprintf('%s%s',output_file_dir,'Time.mat');
        load(file_name);
       
        n=size(Time_MV,2);
        n=n/total_repeat_num;
        for i=1:n
            Time_LFC1(i)=mean(Time_LFC( (i-1)*total_repeat_num+1:i*total_repeat_num));
            Time_PC1(i)=mean(Time_PC( (i-1)*total_repeat_num+1:i*total_repeat_num));
            Time_MV1(i)=mean(Time_MV( (i-1)*total_repeat_num+1:i*total_repeat_num));
            Time_M3V1(i)=mean(Time_M3V( (i-1)*total_repeat_num+1:i*total_repeat_num));
            Time_YAN1(i)=mean(Time_YAN( (i-1)*total_repeat_num+1:i*total_repeat_num));
            Time_Soft_LCM1(i)=mean( Time_Soft_LCM( (i-1)*total_repeat_num+1:i*total_repeat_num) );
        end
        


        
        figure();
        hold on;
        linewidth=2;
        x_label=(begin_num:end_num)*step_num;

        han(1,1)=plot(x_label,log(1+Time_LFC1)/log(10),'-gs','LineWidth',linewidth,'MarkerFaceColor','g');
        han(2,1)=plot(x_label,log(1+Time_PC1)/log(10),'-bs','LineWidth',linewidth,'MarkerFaceColor','b');
        han(3,1)=plot(x_label,log(1+Time_MV1)/log(10),'-cs','LineWidth',linewidth,'MarkerFaceColor','c');
%         han(4,1)=plot(x_label,Time_YAN1,'-ys','LineWidth',linewidth,'MarkerFaceColor','y'); 
        han(4,1)=plot(x_label,log(1+Time_M3V1)/log(10),'-ks','LineWidth',linewidth,'MarkerFaceColor','k');
        han(5,1)=plot(x_label,log(1+Time_Soft_LCM1)/log(10),'-rs','LineWidth',linewidth,'MarkerFaceColor','r'); 
        title('Time comparision','FontSize',16)
        xlabel('The annotator number','FontSize',16);
        ylabel('Runing time(log(t))','FontSize',16);
        legend(han(1:5),'Raykar''s Model','Kajino''s Model','Majority Voting','M3V','Cost-sensitive');        
        temp=[0 10 100 1000 10000];
        set(gca,'YTick',log(1+temp)/log(10))
        set(gca,'YTickLabel',{'0','10','100','1000','10000'})    
        ylim([0,4.1])

        
        figure();
        hold on;
        han(1,1)=plot(x_label,Time_LFC1,'-gs','LineWidth',linewidth,'MarkerFaceColor','g');
        han(2,1)=plot(x_label,Time_MV1,'-cs','LineWidth',linewidth,'MarkerFaceColor','c');
        han(3,1)=plot(x_label,Time_M3V1,'-ks','LineWidth',linewidth,'MarkerFaceColor','k');
        han(4,1)=plot(x_label,Time_Soft_LCM1,'-rs','LineWidth',linewidth,'MarkerFaceColor','r'); 
        han(5,1)=plot(x_label,Time_PC1,'-bs','LineWidth',linewidth,'MarkerFaceColor','b'); 
        title('Time comparision','FontSize',16)
        xlabel('The annotator number','FontSize',16);
        ylabel('Runing time(s)','FontSize',16);
        legend(han(1:4),'Raykar''s Model','Majority Voting','M3V','Cost-sensitive');

        
    end
end
