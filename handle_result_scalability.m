function [  ] = handle_result_scalability( experiment_num )
    Initialization();

    file_name=sprintf('%s%s',output_file_dir,'Time.mat');
    load(file_name);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     file_name=sprintf('%s%s',output_file_dir,'Time_LCM1.mat');
%     load(file_name);
%     for i = 1:110
%         Time_Soft_LCM1( (i-1)*10+1:i*10 ) = Time_Soft_LCM(i);
%     end
%     end_num = 8;
    Time_Soft_LCM = Time_Soft_LCM1;
%     
%     
%     file_name=sprintf('%s%s',output_file_dir,'Time_LFC1.mat');
%     load(file_name);
%     Time_LFC1 = Time_Soft_LCM;
%     for i = 1:110
%         Time_LFC1( (i-1)*10+1:i*10 ) = Time_LFC(i);
%     end
%     Time_LFC = Time_LFC1;    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    n=size(Time_PC,2);
    n=n/total_repeat_num;
    for i=1:n
        time_LFC(i)=mean(Time_LFC( (i-1)*total_repeat_num+1:i*total_repeat_num));
        time_PC(i)=mean(Time_PC( (i-1)*total_repeat_num+1:i*total_repeat_num));
        time_MV(i)=mean(Time_MV( (i-1)*total_repeat_num+1:i*total_repeat_num));
        time_M3V(i)=mean(Time_M3V( (i-1)*total_repeat_num+1:i*total_repeat_num)); 
        time_Soft_LCM(i)=mean( Time_Soft_LCM( (i-1)*total_repeat_num+1:i*total_repeat_num) );
%         time_MV_Probability(i)=mean(Time_MV_Probability( (i-1)*total_repeat_num+1:i*total_repeat_num));
%         time_DS_Estimator(i)=mean(Time_DS_Estimator( (i-1)*total_repeat_num+1:i*total_repeat_num));
    end
    if experiment_num == 48
        x_label = 5:5:5*n;
    else
        x_label = 10:10:10*n;
    end
    linewidth = 1;
    MarkerSize = 6;
    figure();
    hold on
    han(1,1)=plot(x_label, time_MV,'--k','LineWidth',linewidth,'MarkerFaceColor','w','MarkerSize',MarkerSize);
    han(2,1)=plot(x_label, time_M3V,'-k^','LineWidth',linewidth,'MarkerFaceColor','w','MarkerSize',MarkerSize);
    han(3,1)=plot(x_label, time_LFC,'--ko','LineWidth',linewidth,'MarkerFaceColor','w','MarkerSize',MarkerSize);
    han(4,1)=plot(x_label, time_PC,'-kx','LineWidth',linewidth,'MarkerFaceColor','w','MarkerSize',MarkerSize+2);
    han(5,1)=plot(x_label, time_Soft_LCM,'-k','LineWidth',linewidth);
     set(gca, 'YScale','log');
    le=legend(han(1:5),'MV-LFC','M3V-LFC','LC Model','PC Model','CS-LFC-SVM');
    set(le,'Box','off');
    set(le,'FontSize',11)
    title(title_name,'FontSize',16)

    xlabel('The annotator number','FontSize',16);
    ylabel('The computing time (s)','FontSize',16);        

end

