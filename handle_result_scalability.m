function [  ] = handle_result_scalability( experiment_num )
    Initialization();

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
    x_label = 10:10:110;
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
    le=legend(han(1:5),'MV-LFC','M3V-LFC','LC Model','PC Model','CS-LFC');
    set(le,'Box','off');
    set(le,'FontSize',11)

    xlabel('The annotator number','FontSize',16);
    ylabel('The computing time (s)','FontSize',16);        

end

