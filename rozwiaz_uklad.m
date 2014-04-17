function [x, t] = rozwiaz_uklad(u, odstep_czasu, x0, m, M, l, g, fp, fc, ilosc_punktow_czasu)

%% Alokacja pamięci dla zmiennych
x = zeros(ilosc_punktow_czasu, 4);
psi = zeros(ilosc_punktow_czasu, 4);
t = zeros(ilosc_punktow_czasu, 1);

%% Warunki początkowe
x(1, :) = x0;

%% Rozwiązanie równań różniczkowych
for i = 1:ilosc_punktow_czasu-1
    z = x(i, :);
    z = rk4(z, u(i), odstep_czasu, m, M, l, g, fp, fc);
	t(i+1) = t(i) + odstep_czasu;
    x(i+1, :) = z;
end

%% Rozwiązanie sprzężonych równań różniczkowych wstecz
psi(ilosc_punktow_czasu)= [0 0 0 0];

for i = ilosc_punktow_czasu:-1:2
    z = [x(i, :) psi(i, :)];
    z = rk4_a(z, u(i-1), odstep_czasu, m, M, l, g, fp, fc);
    psi(i-1, :) = z(5:8);
end

end

