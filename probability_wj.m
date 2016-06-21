function [ f, g ] = probability_wj( w )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    mylogistic=@(w,x)(  1+exp(-w'*x)  )^(-1);
    emusinou=10^(-10);
    global X_g pz_g Y_t
    [n,d]=size(X_g);
    pz1 = pz_g;
    pz0=1-pz1;
    
    f=0;g=zeros(d,1);
    for i = 1:n
        if Y_t(i,1) == -2
            continue;
        end
        eitai = mylogistic(w,X_g(i,:)');
        if Y_t(i,1) == 1
%             f = f + pz1(i,1)*eitai+ + pz0(i,1)*(1-eitai);
            f = f + pz1(i,1)*log(eitai+emusinou) + pz0(i,1)*log(1-eitai+emusinou);
            g = g + (pz1(i,1)-pz0(i,1))*eitai*(1-eitai)*X_g(i,:)';
        elseif Y_t(i,1) == -1
%             f = f + pz1(i,1)*(1-eitai) + pz0(i,1)*(eitai) ;
            f = f + pz1(i,1)*log(1-eitai+emusinou) + pz0(i,1)*log(eitai+emusinou) ;
            g = g - (pz1(i,1)-pz0(i,1))*eitai*(1-eitai)*X_g(i,:)';
        end
    end
    f=-f;
    g = -g;
end

