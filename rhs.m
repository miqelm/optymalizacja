function [ dx ] = rhs(z, u, parametry)
%% Zmienne pomocnicze
dx = zeros(1, 5);
x2 = z(2);
x3 = z(3);
x4 = z(4);
m = parametry(1);
M = parametry(2);
l = parametry(3);
g = parametry(4);
fp = parametry(5);
fc = parametry(6);

%% Wylicznie prawych stron równañ ró¿niczkowych
dx(1) = x2;
dx(2) = (u + m * l * sin(x3) * x4^2 - m * g * sin(x3) * cos(x3))/(M + m * sin(x3)^2 + fc);
dx(3) = x4;
dx(4) = (-m * g * sin(x3) - m * cos(x3) * dx(2))/(m * l + fp/l);
dx(5) = x3^2;

end

