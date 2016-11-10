clear;
addpath('../tools');
n = 100;
delta = 1;
expert_num = 7;

G(1:n/2,1) = 1;
G(n/2+1:n,1) = -G(1:n/2,1);
Z_test = G; 
w=[1;1];
svm_para=sprintf('%s','-s 0 -t 0');

len = 6;
accuracy1 = zeros(len, 1);
accuracy2 = accuracy1;
accuracy3 = accuracy1;
accuracy4 = accuracy1;
repeat_num = 10;
for i = 1:len
    r = (i-1)*0.1;
    for j = 1:repeat_num   
        X = normrnd(1, delta, [n/2, 2]);
        X(n/2+1:n,:) = -normrnd(1, delta, [n/2, 2]);
        X_test = normrnd(1, delta, [n/2, 2]);
        X_test(n/2+1:n,:) = -normrnd(1, delta, [n/2, 2]);

        value = X*w;
        [a,index]=sort(abs(value));
        Y1 = G;
        Y1(index(1:r*n),1) = -Y1(index(1:r*n),1);
        Y2 = G;
        Y2(index(end-r*n+1:end),1) = -Y2(index(end-r*n+1:end),1);
        index = randperm(n);
        Y3 = G;
        Y3(index(1:r*n),1) = -Y3(index(1:r*n),1);
        Y4 = G;
        Y4(n/2+1:n/2+r*n,1) = -Y4(n/2+1:n/2+r*n,1);
        

        model1 = svmtrain(ones(n,1),Y1,X,svm_para);
        model2 = svmtrain(ones(n,1),Y2,X,svm_para);
        model3 = svmtrain(ones(n,1),Y3,X,svm_para);
        model4 = svmtrain(ones(n,1),Y4,X,svm_para);

        [predict_label_temp,accuracy,decision]=svmpredict(Z_test,X_test,model1);
        accuracy1(i,1) = accuracy1(i,1) + accuracy(1,1);
        [predict_label_temp,accuracy,decision]=svmpredict(Z_test,X_test,model2);
        accuracy2(i,1) = accuracy2(i,1) + accuracy(1,1);        
        [predict_label_temp,accuracy,decision]=svmpredict(Z_test,X_test,model3);
        accuracy3(i,1) = accuracy3(i,1) + accuracy(1,1);  
        [predict_label_temp,accuracy,decision]=svmpredict(Z_test,X_test,model4);
        accuracy4(i,1) = accuracy4(i,1) + accuracy(1,1); 
    end
end

accuracy1 = accuracy1/repeat_num;
accuracy2 = accuracy2/repeat_num;
accuracy3 = accuracy3/repeat_num;
accuracy4 = accuracy4/repeat_num;


figure()
hold on 
linewidth = 2;
f(1) = plot((0:len-1)*0.1, accuracy1, 'r','LineWidth',linewidth);
f(2) = plot((0:len-1)*0.1, accuracy2, 'b','LineWidth',linewidth);
f(3) = plot((0:len-1)*0.1, accuracy3, 'g','LineWidth',linewidth);
f(4) = plot((0:len-1)*0.1, accuracy4, 'm','LineWidth',linewidth);
le=legend(f(1:4),'near CH','far from CH','random','unbalance','FontSize',16);
xlabel('The ratio of wrong label','FontSize',16);
ylabel('The test accuracy (%)','FontSize',16);



% figure()
% hold on 
% for i = 1:n
%     if G(i) == 1
%         type = '*';
%     else
%         type = 'o';
%     end
% 
%     if Y4(i) == G(i)
%         color = 'b';
%     else
%         color = 'r';
%     end
% 
%     line_type = sprintf('%s%s',type, color);
% 
%     plot(X(i,1),X(i,2), line_type);
% end



% 
% 
% 
% figure()
% hold on 
% for i = 1:n/2
%     plot(X_test(i,1),X_test(i,2),'*r');
%     plot(X_test(n/2+i,1),X_test(n/2+i,2),'ob');
% end