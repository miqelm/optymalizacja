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
fc = parametry(6);

%% Wylicznie prawych stron równañ ró¿niczkowych
dx(1) = x2;
dx(2) = (-fc * x2 + m * l * sin(x3) * x4^2 + u + m * g * cos(x3) * sin(x3))/(M + m * sin(x3)^2);
dx(3) = x4;
dx(4) = -(cos(x3) * (-fc * x2 + m * l * sin(x3) * x4^2 + u) + (M + m) * g * sin(x3))/(l * (M + m * sin(x3)^2));
dx(5) = x3^2;

end

