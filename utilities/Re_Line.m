function x = Re_Line(R,m,n)
%R1*N
%m*n=N
    x = zeros(m,n);
    for i=1:n
        for j=1:m
            x(j,i)=R((i-1)*m+j);
        end
    end
end