function [ t, x, dQ, H1, tau, u0] = BFGS(tau, x0, h0, a, Tk, umax, u0)
% Szukanie minimum metod¹ BFGS

e0 = 1e-6;
e1 = 1e-6;
e2 = 1e-3;
e3 = 1e-5;
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
            [~, ~, ~, dQ, ~, epsil] = gradient(x0, xmin, u0, umax, h0, Tk, a);            
            if norm(dQ) < e0
                display('Wychodze bo norma gradientu ma³a');
                break;
            end
%             if epsil < e3 && norm(dQ) > e3
%                 display('Wychodze bo funkcja prze³¹czaj¹ca jest bliska zeru przy przelaczeniach');
%                 break;
%             end
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
                    display('Wychodze bo kolejna odnowa nie da³a skutku');
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
            [xmin, Q, u0] = minkier(x0, d, xmin, h0, a, u0, umax, Tk);           
            krok = 7;
        case 7
            %Krok 7
            if (length(xmin) == length(xs))
                if (mean(xmin == xs) == 1)
                    if R
                        display('Wychodze bo rozwiazanie nie zmienilo sie');
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
            %x
            %display('wskaznik jakosci oraz gradient');
           % norm(dQ')
            [nrIteracji, Q, norm(dQ')]            
            %input('kolejny krok')
    end
end
[t, x, ~, dQ, H1] = gradient(x0, xmin, u0, umax, h0, Tk, a);
tau = xmin;
nrIteracji
end


