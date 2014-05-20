function [ output_args ] = bfgs( x, max_iteration, eps_zero )
bfgs_running = true;
iteration = 0;
N = length(x);
gs = [];

%% 1 krok
R = 1;


while bfgs_running
    iteration = iteration + 1;
    if iteration >= max_iteration
        break
    end
    
    %% 2 krok
    %dQ
    if norm(dQ) <= eps_zero
        break
    end    
    
    %% 3 krok
    if R == 1
        W = eye(N, N);
    else
        r = dQ - gs;
        s = x - xs;
        W = W + (r*r')/(s'*s) - (W*s*s'*W)/(s'*W*s);
    end
    d = -W\dQ;
    
    %% 4 krok
    xs = x;
    gs = dQ;
    
    %% 5 krok
    %poszukiwanie na kierunku
    
    %% 6 krok
    R = 0;   
    
end

end

