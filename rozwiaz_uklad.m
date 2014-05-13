function [x, psi_rozw, dQ, t] = rozwiaz_uklad(u, odstep_czasu, x0, m, M, l, g, fp, fc, ilosc_punktow_czasu)

%% Alokacja pami�ci dla zmiennych
x = zeros(ilosc_punktow_czasu, 5);
t = zeros(ilosc_punktow_czasu, 1);

%% Warunki pocz�tkowe
x(1, :) = x0;

%% Rozwi�zanie r�wna� r�niczkowych
for i = 1:ilosc_punktow_czasu-1
    z = x(i, :);
    z = rk4(z, u(i), odstep_czasu, m, M, l, g, fp, fc);
	t(i+1) = t(i) + odstep_czasu;
    x(i+1, :) = z;
end

%% Rozwi�zanie sprz�onych r�wna� r�niczkowych wstecz
psi_rozw(ilosc_punktow_czasu, :)= [0 0 0 0];

for i = ilosc_punktow_czasu:-1:2
    z = [x(i, 1:4) psi_rozw(i, :)];
    z = rk4_a(z, u(i-1), odstep_czasu, m, M, l, g, fp, fc);
    psi_rozw(i-1, :) = z(5:8);
end

dQ = zeros(length(x0), 1);
%% Sprawdzanie
epsil = 1e-6;
Q = cost(u, odstep_czasu, x0, m, M, l, g, fp, fc, ilosc_punktow_czasu);
for i = 1:length(x0)
    x0_ = x0;
    x0_(i) = x0_(i) + epsil;
    Q_ = cost(u, odstep_czasu, x0_, m, M, l, g, fp, fc, ilosc_punktow_czasu);
    dQ(i) = (Q_ - Q)/epsil;
end

end

