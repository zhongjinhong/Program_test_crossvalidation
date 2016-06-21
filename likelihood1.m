function [f,g] = likelihood1(w)
    global X_global miu ai bi;
    emusinou=10^(-50);
    sigmod=@(w,x)(  1+exp(-w'*x')  )^(-1); 
    
    f=0;
    n=size(X_global,1);
    pi=zeros(n,1);
    for i=1:n
        pi(i)=sigmod(w,X_global(i,:));
    end
    for i=1:n
        f=f+miu(i)*log( pi(i)*ai(i)+emusinou )+(1-miu(i))*log( (1-pi(i))*bi(i)+emusinou );
    end
    f=-f;
    
    g=0;
    for i=1:n
        g=g+(miu(i)-pi(i))*X_global(i,:)';
    end
    g=-g;
    
end