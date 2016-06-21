function [w]=YAN(X,Y)
    options = optimset('GradObj','on');
    options.TolX=0.1;
    options.MaxFunEvals=1000;
    options.MaxIter=20;

    global X_g Y_g pz_g Y_t;

    [n,d]=size(X);
    expert_num = size(Y,2);
    
    X_g = X;
    X_g(:,d+1) = 1;
    Y_g=Y;
    W = rand(d+1,expert_num+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     W = 1000*(rand(d+1,expert_num+1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    W(:,expert_num+1)=0;

    t=1;
    while t<=100
        w_old = W(:,expert_num+1);
        pz_g = estimate_zi(W);
        W(:,expert_num+1)=fminlbfgs(@logistic_probability,W(:,expert_num+1),options);
        w_new = W(:,expert_num+1);
        for j=1:expert_num
            Y_t = Y(:,j);
            W(:,j) = fminlbfgs(@probability_wj,W(:,j),options);
            show_message=sprintf('t=%d\tj=%d',t,j);
            disp(show_message);
        end

        if norm(w_new-w_old,2)< 0.01;
            break
        end
        t=t+1;    
    end
    w=W(:,expert_num+1);
    clear w0;
end