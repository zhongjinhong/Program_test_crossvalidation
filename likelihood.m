function [g,h] = likelihood(X,Y,miu,w)
    
    sigmod=@(w,x)(  1+exp(-w'*x')  )^(-1); 
    
    [n,d]=size(X);
    pi=zeros(n,1);
    
    for i=1:n
        pi(i,1)=sigmod(w,X(i,:));
    end
       
    
   g=0;
   for i=1:n
       g=g+(miu(i)-pi(i))*X(i,:)';
   end

   
   h=zeros(d,d);
   for i=1:n
       h=h-pi(i)*(1-pi(i))*X(i,:)'*X(i,:);
   end
   
    
end
