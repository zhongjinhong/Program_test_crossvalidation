function [ ai,bi ] = calculate_ai_bi(alpha,beta,Y)
    [n,m]=size(Y);
    ai=ones(n,1);
    bi=ai;
    for i=1:n
        for j=1:m
            if Y(i,j)~= -2
                ai(i,1)=ai(i,1)*alpha(j)^(Y(i,j))*(1-alpha(j))^(1-Y(i,j));
                bi(i,1)=bi(i,1)*beta(j)^(1-Y(i,j))*(1-beta(j))^(Y(i,j));
            end
        end
        
        max_value = max(ai(i,1),bi(i,1));
        if(max_value > 0)
            ai(i,1) = ai(i,1)/max_value;
            bi(i,1) = bi(i,1)/max_value;
        end
        
    end
end

