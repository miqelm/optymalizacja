function [ t, x, tau, u0] = BFGS(tau, x0, h0, parametry, Tk, umax, u0)
% Szukanie minimum metodπ BFGS

e0 = 1e-6;
e1 = 1e-6;
e2 = 1e-3;
R  = 1;
xmin  = tau;
krok   = 2;
odnowa = 0;
nrIteracji = 0;
while (1)
    % Krok 2
    switch krok
        case 2          
            if isempty(xmin)
                break;
            end
            nrIteracji = nrIteracji + 1;
            [~, ~, ~, dQ, ~] = gradient(x0, xmin, u0, umax, h0, Tk, parametry);            
            if norm(dQ) < e0
                display('Norma gradientu za ma≥a. Koniec.');
                break;
            end
            krok = 3;
        case 3
            %Krok 3
            if R
                W = eye(length(dQ));
            else
                r = dQ-gs;
                s = xmin-xs;
                W = W + (r*(r'))/((s')*r)-(W*s*(s')*W)/((s')*W*s);
            end
            d = -W\dQ;
            krok = 4;
        case 4
            %Krok 4
            if d'*dQ > -max(e1, e2*norm(dQ)^2)
                R = 1;
                if odnowa == 1
                    display('Odnowa nie przynios≥a poprawy. Koniec.');
                    break;
                else
                    krok = 3;
                    odnowa = odnowa + 1;
                end
            else
                krok = 5;
                odnowa = 0;
            end
        case 5
            %Krok 5
            xs = xmin;
            gs = dQ;
            krok = 6;
        case 6
            %Krok 6
            [xmin, Q, u0] = minkier(x0, d, xmin, h0, parametry, u0, umax, Tk);           
            krok = 7;
        case 7
            %Krok 7
            if (length(xmin) == length(xs))
                if (mean(xmin == xs) == 1)
                    if R
                        display('Rozwiπzanie nie uleg≥o zmianie. Koniec.');
                        break;
                    else
                        R = 1;
                        krok = 3;
                    end
                else
                    R = 0;
                    krok = 2;
                end
            else
                R = 1;
                krok = 2;
            end            
            fprintf('Iteracja %3.d, wskaünik jakoúci: %.8f, norma gradientu %.8f\n', nrIteracji, Q, norm(dQ'))
    end
    if nrIteracji == 200
        break
    end
end
[t, x, ~, dQ, ~] = gradient(x0, xmin, u0, umax, h0, Tk, parametry);
fprintf('Iteracja %3.d, wskaünik jakoúci: %.8f, norma gradientu %.8f\n', nrIteracji, Q, norm(dQ'))
tau = xmin;
end


