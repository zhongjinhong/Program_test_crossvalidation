function [f,g] = MAP1(w)
   global X_g Y_g miu_g;
   global w0; 

   
   sigmod=@(w,x)(  1+exp(-w'*x')  )^(-1); 
   epsilon = 10^(-20);
   
   [n,d]=size(X_g);
   pi=zeros(n,1);
   for i=1:n
       pi(i,1)=sigmod(w,X_g(i,:));
   end
   
   
   f=0.5*miu_g*norm(w-w0,2);
   g=miu_g*(w-w0);
   for i=1:n
       if Y_g(i,1)~= -2
           g=g-( Y_g(i,1)-pi(i,1) )*X_g(i,:)';
           f = f - Y_g(i,1)*log(pi(i,1) + epsilon ) - (1-Y_g(i,1))*log(1-pi(i,1)+epsilon);
       end
       if (isnan(f))
           break;
       end
   end
end
