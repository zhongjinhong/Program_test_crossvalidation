function [ pz ] = estimate_zi( W )
    mylogistic=@(w,x)(  1+exp(-w'*x)  )^(-1);
    emusinou=10^(-10);
    global X_g Y_g;
    [n,expert_num] = size(Y_g);
    pz1 = ones(n,1);
    pz0 = pz1;
    
    eita = zeros(n,expert_num);
    for i = 1:n
        pz1(i,1) = mylogistic(W(:,expert_num+1),X_g(i,:)');
        pz0(i,1) = 1 - pz1(i,1);
        for t = 1:expert_num
            if Y_g(i,t)~= -2
                eita(i,t)=mylogistic(W(:,t),X_g(i,:)');
                if(Y_g(i,t)==1)
                    pz1(i,1)=pz1(i,1)*( eita(i,t)+emusinou );
                    pz0(i,1)=pz0(i,1)*(1-eita(i,t)+emusinou);
                else
                    pz1(i,1)=pz1(i,1)*(1-eita(i,t)+emusinou);
                    pz0(i,1)=pz0(i,1)*(eita(i,t)+emusinou);
                end
            end
        end
        pz1(i,1)=pz1(i,1)/( pz1(i,1)+pz0(i,1) );
    end
    pz = pz1;
end

