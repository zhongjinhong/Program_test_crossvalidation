function [  ] = handle_result_load_data( experiment_num )
    Initialization();

    repeat_num=total_repeat_num;
    file_name = sprintf('%s%s',output_file_dir,'plot_data.mat');
    load(file_name);
    
    accuracy_result = [acc_MV,acc_M3V,acc_LFC,acc_PC,acc_Soft_LCM1]
    std_result      = [std_MV,std_M3V,std_LFC,std_PC,std_Soft_LCM1]    
    
    accuracy_result = [acc_MV_Probability,acc_DS_Estimator,acc_Soft_LCM2,acc_Soft_LCM1]
    std_result      = [std_MV_Probability,std_DS_Estimator,std_Soft_LCM2,std_Soft_LCM1]
    
    [h12,p12,ci12,status12]=ttest(Result_LCM1,Result_LCM2);    
    
    
end

