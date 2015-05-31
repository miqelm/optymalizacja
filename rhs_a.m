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
m = parametry.m;
M = parametry.M;
l = parametry.l;
g = parametry.g;
fc = parametry.fc;

%% Wylicznie prawych stron równañ ró¿niczkowych
dx(1) = x2;
dx(2) = (-fc * x2 + m * l * sin(x3) * x4^2 + u + m * g * cos(x3) * sin(x3))/(M + m * sin(x3)^2);
dx(3) = x4;
dx(4) = -(cos(x3) * (-fc * x2 + m * l * sin(x3) * x4^2 + u) + (M + m) * g * sin(x3))/(l * (M + m * sin(x3)^2));

dx(5) = 0;
dx(6) = (Psi2*fc)/(m*sin(x3)^2 + M) - Psi1 - (Psi4*fc*cos(x3))/(l*(m*sin(x3)^2 + M));
dx(7) = 2*x3 - (Psi2*(g*m*cos(x3)^2 - g*m*sin(x3)^2 + l*m*x4^2*cos(x3)))/(m*sin(x3)^2 + M) + (Psi4*(g*cos(x3)*(M + m) - sin(x3)*(l*m*sin(x3)*x4^2 + u - fc*x2) + l*m*x4^2*cos(x3)^2))/(l*(m*sin(x3)^2 + M)) + (2*Psi2*m*cos(x3)*sin(x3)*(l*m*sin(x3)*x4^2 + u - fc*x2 + g*m*cos(x3)*sin(x3)))/(m*sin(x3)^2 + M)^2 - (2*Psi4*m*cos(x3)*sin(x3)*(cos(x3)*(l*m*sin(x3)*x4^2 + u - fc*x2) + g*sin(x3)*(M + m)))/(l*(m*sin(x3)^2 + M)^2);
dx(8) = (2*Psi4*m*x4*cos(x3)*sin(x3))/(m*sin(x3)^2 + M) - (2*Psi2*l*m*x4*sin(x3))/(m*sin(x3)^2 + M) - Psi3;

end

