i = 3;for j = 1:3 produce_all_data(i,j);end
i = 8;for j = 1:3 produce_all_data(i,j);end
produce_all_data(,4)
compare()
for num = 12:-1:7 compare(num);end
for num = 21:23 compare(num);end; for num = 25:27 compare(num);end
compare(7)

for i = 1:1000
    for j = 1:10
        if (wrong_value_lcm(i,j) ~= 0)
            wrong_value_lcm(i,j) = abs(wrong_value_lcm(i,j) - 0.5);
        end
        if (wrong_value_lfc(i,j) ~= 0)
            wrong_value_lfc(i,j) = abs(wrong_value_lfc(i,j) - 0.5);
        end        
        
    end
end


count1 = 0;
count2 = 0;
sum1 = 0;
sum2 = 0;
for i = 1:1000
    for j = 1:10
        if (wrong_value_lcm(i,j) ~= 0)
            count1 = count1 +1;
            sum1 = sum1 + wrong_value_lcm(i,j);
        end
        if (wrong_value_lfc(i,j) ~= 0)
            count2 = count2 + 1;
            sum2 = sum2 + wrong_value_lfc(i,j);
        end        
        
    end
end


7:()
acc=[acc_LFC,acc_M3V,acc_MV,acc_PC,acc_Soft_LCM2];
name = {'LFC','M3V','MV','PC','CS-LFC'};
[acc_sort,index]=sort(acc,'descend');
name(index)
result=zeros(20,1);
for i = 1:20
    result(i,1) = norm(W_LFC(i,:),2);
end
