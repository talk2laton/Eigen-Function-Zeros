function z = Nzeros(fun, xmin, xmax, N)
    %% This function computes atmost N zeros (z) between xmin and xmax
    % fun is the handle to the function whose zeros we want to compute
    % xmin is the start of the search region
    % xmax is the end of the search region
    % N is the maximum number of the zeros we sort
    % Example 1: z = Nzeros(@(x)besselj(0,x), 0, 20, 7)
    % Example 2: z = Nzeros(@(x)sin(x*pi), 0, 20, 7)
    % Example 3: z = Nzeros(@(x)besselj(0,x) - 2*besselj(1,x), 0, 20, 7)
    % Example 4: z = Nzeros(@(x)3*sin(2*x) - x*cos(3*x), 0, 20, 7)
    NN = 1000*N; x = linspace(xmin, xmax, NN+1);
    f = arrayfun(@(x)fun(x), x); z = zeros(1, N); j = 1;
    for i = 1:NN
        fa = f(i); fb = f(i+1);
        if(fa*fb < 0)
            a = x(i); b = x(i+1);
            converged = 0;
            while(~converged)
                t = -fa / (fb - fa); c = a + t * (b - a); fc = fun(c);
                if(fa*fc < 0)
                    b = c; fb = fc;
                else
                    a = c; fa = fc;
                end
                converged = abs(fc)<1e-12;
            end
            z(j) = c; j = j + 1;
            if(j > N)
                break;
            end
        end
    end
    z(j:end) = []; plot(x,f); refline(0,0); hold on; 
    plot(z, zeros(size(z)), 'ro', 'markerfacecolor','r'); 
end