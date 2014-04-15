function [ dx ] = rhs( z, u, m, M, l, g, fp, fc)
%% Zmienne pomocnicze
x2 = z(2);
x3 = z(3);
x4 = z(4);

%% Wylicznie prawych stron równañ ró¿niczkowych
dx1 = x2;
dx2 = (u + m * l * sin(x3) * x4^2 - m * g * sin(x3) * cos(x3))/(M + m * sin(x3)^2 + fc);
dx3 = x4;
dx4 = (-m * g * sin(x3) - m * cos(x3) * dx2)/(m * l + fp/l);

%% Zwrócenie wyniku
dx = [dx1 dx2 dx3 dx4];

end

