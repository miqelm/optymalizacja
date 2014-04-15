function [x, t] = rozwiaz_uklad(u, odstep_czasu, x0, m, M, l, g, fp, fc, ilosc_punktow_czasu)

%% Alokacja pamiêci dla zmiennych
x = zeros(ilosc_punktow_czasu, 4);
t = zeros(ilosc_punktow_czasu, 1);

%% Warunki pocz¹tkowe
x(1, :) = x0;

%% Rozwi¹zanie równañ ró¿niczkowych
for i = 1:ilosc_punktow_czasu-1
    z = x(i, :);
    z = rk4(z, u(i), odstep_czasu, m, M, l, g, fp, fc);
	t(i+1) = t(i) + odstep_czasu;
    x(i+1, :) = z;
end

end

