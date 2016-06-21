function [pi]=calculate_pi(w,X)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    sigmod=@(w,x)(  1+exp(-w'*x')  )^(-1); 
    
    n=size(X,1);
    pi=zeros(n,1);
    
    for i=1:n
        pi(i,1)=sigmod(w,X(i,:));
    end
       

end

