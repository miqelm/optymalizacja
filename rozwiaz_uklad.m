function [x, psi_rozw, dQ, t] = rozwiaz_uklad(u, odstep_czasu, x0, parametry, ilosc_punktow_czasu)

%% Zmienne pomocnicze
m = parametry(1);
M = parametry(2);
l = parametry(3);
g = parametry(4);
fp = parametry(5);
fc = parametry(6);

%% Alokacja pamiêci dla zmiennych
x = zeros(ilosc_punktow_czasu, 5);
t = zeros(ilosc_punktow_czasu, 1);

%% Warunki pocz¹tkowe
x(1, :) = x0;

%% Rozwi¹zanie równañ ró¿niczkowych
for i = 1:ilosc_punktow_czasu-1
    z = x(i, :);
    z = rk4(z, u(i), odstep_czasu, parametry);
	t(i+1) = t(i) + odstep_czasu;
    x(i+1, :) = z;
end

%% Rozwi¹zanie sprzê¿onych równañ ró¿niczkowych wstecz
xT = parametry(7);
psi_rozw(ilosc_punktow_czasu, :)= [2*xT-2*x(end,1) 0 0 0];

for i = ilosc_punktow_czasu:-1:2
    z = [x(i, 1:4) psi_rozw(i, :)];
    z = rk4_a(z, u(i-1), odstep_czasu, parametry);
    psi_rozw(i-1, :) = z(5:8);
end

dQ = zeros(length(x0), 1);
%% Sprawdzanie
epsil = 1e-6;
Q = cost(u, odstep_czasu, x0, parametry, ilosc_punktow_czasu);
for i = 1:length(x0)
    x0_ = x0;
    x0_(i) = x0_(i) + epsil;
    Q_ = cost(u, odstep_czasu, x0_, parametry, ilosc_punktow_czasu);
    dQ(i) = (Q_ - Q)/epsil;
end

end

