total_repeat_num=100;
begin_num=1;
end_num=1;
% count=zeros(2*end_num*step_num,(end_num-begin_num+1)*total_repeat_num); 
switch experiment_num
    case 1
        input_file_dir='../Input Data/Adult/Clustering/';
        output_file_dir='../Output Data/Adult/Clustering/';
        title_name='Adult(Yan Yan''s Data)'; 
    case 2
        input_file_dir='../Input Data/Adult/latent model/';
        output_file_dir='../Output Data/Adult/latent model/';
        title_name='Adult(Raykar''s Data)'; 
    case 3
        input_file_dir='../Input Data/Adult/expertise_difficult_model/';
        output_file_dir='../Output Data/Adult/expertise_difficult_model/';
        title_name='Adult(Whitehill''s Data)'; 
    case 4
        input_file_dir='../Input Data/Conect/Clustering/';    
        output_file_dir='../Output Data/Conect/Clustering/';
        title_name=('Conect(Yan Yan''s Data)'); 
    case 5
        input_file_dir='../Input Data/Conect/latent model/';
        output_file_dir='../Output Data/Conect/latent model/';
        title_name='Conect(Raykar''s Data)';
    case 6
        input_file_dir='../Input Data/Conect/expertise_difficult_model/';
        output_file_dir='../Output Data/Conect/expertise_difficult_model/';
        title_name='Conect(Whitehill''s Data)'; 
                
    case 7
        input_file_dir='../Input Data/mushroom/Clustering/';
        output_file_dir='../Output Data/mushroom/Clustering/';
        title_name='mushroom(Yan Yan''s Data)';
    case 8
        input_file_dir='../Input Data/mushroom/latent model/';
        output_file_dir='../Output Data/mushroom/latent model/';
        title_name='mushroom(Raykar''s Data)';        
    case 9
        input_file_dir='../Input Data/mushroom/expertise_difficult_model/';
        output_file_dir='../Output Data/mushroom/expertise_difficult_model/';
        title_name='mushroom(Whitehill''s Data)';

    case 10
        input_file_dir='../Input Data/test_data/Clustering/';
        output_file_dir='../Output Data/test_data/Clustering/';
        title_name='test_data(Yan Yan''s Data)'; 
    case 11
        input_file_dir='../Input Data/test_data/latent model/';
        output_file_dir='../Output Data/test_data/latent model/';
        title_name='test_data(Raykar''s Data)'; 
    case 12
        input_file_dir='../Input Data/test_data/expertise_difficult_model/';
        output_file_dir='../Output Data/test_data/expertise_difficult_model/';
        title_name='test_data(Whitehill''s Data)';         
        
    case 21 %%total_repeat_num=10 needs about 12h
        input_file_dir='../Input Data/Real Data/Clustering/';
        output_file_dir='../Output Data/Real Data/Clustering/';
        title_name='Twitter Topic(Yan Yan''s Data)';
    case 22
        input_file_dir='../Input Data/Real Data/latent model/';
        output_file_dir='../Output Data/Real Data/latent model/';
        title_name='Twitter Topic(Raykar''s Data)';
    case 23
        input_file_dir='../Input Data/Real Data/expertise_difficult_model/';
        output_file_dir='../Output Data/Real Data/expertise_difficult_model/';
        title_name='Twitter Topic(Whitehill''s Data)';
    case 24
        input_file_dir='../Input Data/Real Data/Real Label/';
        output_file_dir='../Output Data/Real Data/Real Label/';
        title_name='Twitter Topic(Real Data)';
    
    case 25
        input_file_dir='../Input Data/Real_Data_AAAI_balance/Clustering/';
        output_file_dir='../Output Data/Real_Data_AAAI_balance/Clustering/';
        title_name='NER(Clustering)';       
    case 26
        input_file_dir='../Input Data/Real_Data_AAAI_balance/latent model/';
        output_file_dir='../Output Data/Real_Data_AAAI_balance/latent model/';
        title_name='NER(Raykar''s Data)';                  
    case 27
        input_file_dir='../Input Data/Real_Data_AAAI_balance/expertise_difficult_model/';
        output_file_dir='../Output Data/Real_Data_AAAI_balance/expertise_difficult_model/';
        title_name='NER(Whitehill''s Data)';       
    case 28
        input_file_dir='../Input Data/Real_Data_AAAI_balance/Real Label/';
        output_file_dir='../Output Data/Real_Data_AAAI_balance/Real Label/';
        title_name='NER(Real Data)';     
        
        
    case 29
        input_file_dir='../Input Data/system_error/';
        output_file_dir='../Output Data/system_error/';
        title_name='Artificial Dataset';   
        total_repeat_num=1100;
        
        
    case 30
        input_file_dir='../Input Data/system_error_new/';
        output_file_dir='../Output Data/system_error_new/';    
        title_name='type2';
        total_repeat_num=100;end_num=11;
        xlabel_name='# annotators with systematic noise / # normal annotators';
        
    case 31
        input_file_dir='../Input Data/system_error_new2/';
        output_file_dir='../Output Data/system_error_new2/';    
        title_name='type3';
        total_repeat_num=100;end_num=11;
        xlabel_name='# annotators with systematic noise / # normal annotators';        
        
        
    case 40
        input_file_dir ='../Input Data/system_error/';
        output_file_dir='../Output Data/system_error/';
        total_repeat_num=100;end_num=11;
        title_name='type 1';  
        xlabel_name='# annotators with systematic noise / # normal annotators';
        
        
    case 42
        input_file_dir ='../Input Data/Real Data/latent model/';
        output_file_dir='../Output Data/Real Data Clustering/latent model/';
        total_repeat_num=10;end_num=11;
        title_name='Twitter Topic(Raykar''s Data)'; 
    case 43
        input_file_dir ='../Input Data/Real Data/expertise_difficult_model/';
        output_file_dir='../Output Data/Real Data Clustering/expertise_difficult_model/';
        total_repeat_num=10;end_num=11;
        title_name='Twitter Topic(Whitehill''s Data)'; 
    case 44
        input_file_dir ='../Input Data/Real Data/Real Label/';
        output_file_dir='../Output Data/Real Data Clustering/Real Label/';
        total_repeat_num=10;end_num=11;
        title_name='Twitter Topic(Real Data)';    

    case 45
        input_file_dir ='../Input Data/Real Data/Clustering/';
        output_file_dir='../Output Data/Real Data Random1/Clustering/';
        total_repeat_num=100;end_num=11;
        title_name='Twitter Topic(Clustering data)';
        xlabel_name='# annotators with random noise / # normal annotators';
    case 46
        input_file_dir ='../Input Data/Real Data/latent model/';
        output_file_dir='../Output Data/Real Data Random1/latent model/';
        total_repeat_num=100;end_num=11;
        title_name='Twitter Topic(Raykar''s Data)'; 
        xlabel_name='# annotators with random noise / # normal annotators';
    case 47
        input_file_dir ='../Input Data/Real Data/expertise_difficult_model/';
        output_file_dir='../Output Data/Real Data Random1/expertise_difficult_model/';
        total_repeat_num=100;end_num=11;
        title_name='Twitter Topic(Whitehill''s Data)'; 
        xlabel_name='# annotators with random noise / # normal annotators';
    case 48
        input_file_dir ='../Input Data/Real Data/Real Label/';
        output_file_dir='../Output Data/Real Data Random1/Real Label/';
        total_repeat_num=100;end_num=11;
        title_name='Twitter Topic(Real Label)';  
        xlabel_name='# annotators with random noise / # normal annotators';

    case 49
        input_file_dir ='../Input Data/Real Data/Clustering/';
        output_file_dir='../Output Data/Real Data Random2/Clustering/';
        total_repeat_num=100;end_num=11;
        title_name='Twitter Topic(Clustering Data)'; 
        xlabel_name='# annotators with consistent noise / # normal annotators';
    case 50
        input_file_dir ='../Input Data/Real Data/latent model/';
        output_file_dir='../Output Data/Real Data Random2/latent model/';
        total_repeat_num=100;end_num=11;
        title_name='Twitter Topic(Raykar''s Data)'; 
        xlabel_name='# annotators with consistent noise / # normal annotators';
    case 51
        input_file_dir ='../Input Data/Real Data/expertise_difficult_model/';
        output_file_dir='../Output Data/Real Data Random2/expertise_difficult_model/';
        total_repeat_num=100;end_num=11;
        title_name='Twitter Topic(Whitehill''s Data)'; 
        xlabel_name='# annotators with consistent noise / # normal annotators';
    case 52
        input_file_dir ='../Input Data/Real Data/Real Label/';
        output_file_dir='../Output Data/Real Data Random2/Real Label/';
        total_repeat_num=100;end_num=11;
        title_name='Twitter Topic(Real Label)';  
        xlabel_name='# annotators with consistent noise / # normal annotators';
end
