function [x1,flag]=newton(W0,fun,X,Y,miu) 
    x0=W0;
    i=0;
    d=size(X,2);
    E=eye(d);
    flag=0;
    while i<= 100
        [g,h]=fun(X,Y,miu,x0);
        invh=inv(h);
        if(  norm( invh*h-E,2)>10^(-6)|| max(max(isinf(invh)))  )
            x1=x0;
            flag=1;
            break
        end
        x1=x0-invh*g;
        if norm(x1/norm(x1,2)-x0/norm(x0,2),2)>0.01;
            x0=x1;
        else break
        end
        i=i+1;
        print i;
    end
end