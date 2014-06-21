function [ dx ] = rhs_a(z, u, parametry)
%% Zmienne pomocnicze
dx = zeros(1, 8);
x2 = z(2);
x3 = z(3);
x4 = z(4);
Psi1 = z(5);
Psi2 = z(6);
Psi3 = z(7);
Psi4 = z(8);
m = parametry(1);
M = parametry(2);
l = parametry(3);
g = parametry(4);
fp = parametry(5);
fc = parametry(6);

%% Wylicznie prawych stron równañ ró¿niczkowych
dx1 = x2;
dx2 = (u + m * l * sin(x3) * x4^2 - m * g * sin(x3) * cos(x3))/(M + m * sin(x3)^2 + fc);
dx3 = x4;
dx4 = (-m * g * sin(x3) - m * cos(x3) * dx2)/(m * l + fp/l);

dPsi1 = 0;
dPsi2 = -Psi1;
dPsi3 = 2*x3 - (Psi2*(g*m*sin(x3)^2 - g*m*cos(x3)^2 + l*m*x4^2*cos(x3)))/(m*sin(x3)^2 + M + fc) + (Psi4*(g*m*cos(x3) - (m*sin(x3)*(l*m*sin(x3)*x4^2 + u - g*m*cos(x3)*sin(x3)))/(m*sin(x3)^2 + M + fc) + (m*cos(x3)*(g*m*sin(x3)^2 - g*m*cos(x3)^2 + l*m*x4^2*cos(x3)))/(m*sin(x3)^2 + M + fc) - (2*m^2*cos(x3)^2*sin(x3)*(l*m*sin(x3)*x4^2 + u - g*m*cos(x3)*sin(x3)))/(m*sin(x3)^2 + M + fc)^2))/(l*m + fp/l) + (2*Psi2*m*cos(x3)*sin(x3)*(l*m*sin(x3)*x4^2 + u - g*m*cos(x3)*sin(x3)))/(m*sin(x3)^2 + M + fc)^2;
dPsi4 = (2*Psi4*l*m^2*x4*cos(x3)*sin(x3))/((l*m + fp/l)*(m*sin(x3)^2 + M + fc)) - (2*Psi2*l*m*x4*sin(x3))/(m*sin(x3)^2 + M + fc) - Psi3;

%% Zwrócenie wyniku
dx = [dx1 dx2 dx3 dx4 dPsi1 dPsi2 dPsi3 dPsi4];

end

