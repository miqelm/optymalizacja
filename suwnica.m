%% MAIN
clear all;
close all;
format compact
format long e
parametry

%% WARUNKI POCZ¥TKOWE
x0 = 10;
xprim0 = 0;
theta0 = 0;
thetaprim0 = 0.05;
x0 = [x0 xprim0 theta0 thetaprim0];

%% STEROWANIE
u = zeros(ilosc_punktow_czasu, 1);
for i = 1:length(u)
   if i <= length(u)/4
        u(i) = 0;
   elseif i <= length(u)/2
        u(i) = -1;
   else
       u(i) = 0;
   end
end

%% OBLICZENIA
[x, t] = rozwiaz_uklad(u, odstep_czasu, x0, m, M, l, g, fp, fc, ilosc_punktow_czasu);

%% TRAJEKTORIE
trajektorie