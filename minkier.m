function [ zmin, Qmin, u0 ] = minkier( x0, d0, z0, h0, a, u0, umax, tf )
%Poszukiwanie minimum na kierunku
N    = 10;
beta = 0.5;
e0   = h0;
Q0   = cost(x0, z0, u0, umax, h0, tf, a);
d    = d0;
Qmin = Q0;
zmin = z0;

%Wyznaczenie kroku s
s0 = 1;
for i = 1:length(d)-1
    if d(i)-d(i+1) > 0
        s0 =[s0, (z0(i+1)-z0(i))/(d(i)-d(i+1))];
    end
end
s = min(s0);
z = z0 + d0.*s;

%Kontrakcja w kierunku d
for i = 1:N
    if (z(1) < 0)
        z=z(2:end);
        u0 = -u0;
        d = d(2:end);
    end
    j = 1;
    len = length(z)-1;
    while j <= len
        if (z(j+1) - z(j)) < e0
            z = [z(1:j-1); z(j+2:end)];
            len = length(z)-1;
            j = j-1;
            if j < 1
                j = 1;
            end
        else
            j = j + 1;
        end
    end
    if ~isempty(z)
        if z(end) > tf
            z(end) = tf;
        end
    end
    Q = cost(x0, z, u0, umax, h0, tf, a);
    if Q < Q0
        Qmin = Q;
        zmin = z;
        break;
    else
        z = z0+d0.*beta.*s;
        beta = beta*0.5;
    end
end
if Qmin >= Q0
    beta = 0.5;
    z = z0 - d0.*s;
    for i = 1:N
        if (z(1) < 0)
            z=z(2:end);
            u0 = umax-u0;
            d = d(2:end);
        end
        j = 1;
        len = length(z)-1;
        while j <= len
            if (z(j+1) - z(j)) < e0
                if j < len-1
                    z = [z(1:j-1); z(j+2:end)];
                else
                    z = z(1:j-1);
                end
                len = length(z)-1;
                j = j-1;
                if j < 1
                    j = 1;
                end
            else
                j = j + 1;
            end
        end
        if ~isempty(z)
            if z(end) > tf
                z(end) = tf;
            end
        end
        Q = cost(x0, z, u0, umax, h0, tf, a);
        if Q < Q0
            display('znalazlem szukajac w druga strone');
            Qmin = Q;
            zmin = z;
            break;
        else
            z = z0-d0.*beta.*s;
            beta = beta*0.5;
        end
    end
end
end

