%% MAIN
clear all;
close all;
format compact
format long e
parametry

%% WARUNKI POCZĄTKOWE
x0 = 0;
xprim0 = 0;
theta0 = 0;
thetaprim0 = 0;
x0 = [x0 xprim0 theta0 thetaprim0];

%% STEROWANIE
u = zeros(ilosc_punktow_czasu, 1);
for i = 1:length(u)
   if i <= length(u)/2
        u(i) = 1;
   else
        u(i) = -1;
   end
end

%% OBLICZENIA
[x, psi_prim, t] = rozwiaz_uklad(u, odstep_czasu, x0, m, M, l, g, fp, fc, ilosc_punktow_czasu);

%% TRAJEKTORIE
trajektorie