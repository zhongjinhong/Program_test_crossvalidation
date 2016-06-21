function [w]=PC(X,Y)
    options = optimset('GradObj','on');
    options.TolX=0.1;
    options.MaxFunEvals=1000;
    options.MaxIter=20;

    global w0 X_g Y_g miu_g;
    d=size(X,2);    
    w0=rand(d,1);
    X_g = X;

    m=size(Y,2);
    miu=1;eita=1;
    miu_g = miu;

    for j=1:m
        w(:,j)=rand(d,1);
    end

    t=1;
    while t<=10
        for j=1:m
%             [w(:,j),flag]=newton(w(:,j),@MAP,X,Y(:,j),miu);
            Y_g = Y(:,j);
            w(:,j) = fminlbfgs(@MAP1,w(:,j),options);
            show_message=sprintf('t=%d\tj=%d',t,j);
            disp(show_message);
            
        end
        w1=miu*sum(w,2)/(eita+m*miu);

        if norm(w1-w0,2)>0.001;
            w0=w1;
        else
            break
        end
        t=t+1;    
    end
    w=w0;
    clear w0;
end