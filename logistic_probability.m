function [ f, g ] = logistic_probability( w )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    mylogistic=@(w,x)(  1+exp(-w'*x)  )^(-1);
    emusinou=10^(-10);
    global X_g pz_g
    [n,d]=size(X_g);
    pz1 = pz_g;
    pz0=1-pz1;
    
    f=0;g=zeros(d,1);
    for i = 1:n
        logistic1 = mylogistic(w,X_g(i,:)');
        logistic0 = 1 - logistic1;
        f = f +  pz1(i,1)*log(logistic1+emusinou) + pz0(i,1)*log(logistic0+emusinou) ;
%         f = f +  pz1(i,1)*logistic1 + pz0(i,1)*logistic0;
        g = g + (pz1(i,1)-pz0(i,1))*(logistic1*logistic0)*X_g(i,:)';
    end
    f = -f;
    g = -g;
    
end

