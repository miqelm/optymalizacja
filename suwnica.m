%% MAIN
clear all;
close all;
format compact
format long e
parametry

%% WARUNKI POCZ¥TKOWE
x0 = 0;
xprim0 = 0;
theta0 = 0;
thetaprim0 = 0;
x0 = [x0 xprim0 theta0 thetaprim0 0];

%% STEROWANIE
u = zeros(ilosc_punktow_czasu, 1);
for i = 1:length(u)
   if i <= length(u)/4
        u(i) = 1;
   else
        u(i) = -1;
   end
end

%% Nowy sposób
nowy_sposob

%% OBLICZENIA
% [x, psi_rozw, dQ, t] = rozwiaz_uklad(u, odstep_czasu, x0, m, M, l, g, fp, fc, ilosc_punktow_czasu);
% 
% wyliczone = psi_rozw(1, :)'
% sprawdzone = dQ(1:4)

%% TRAJEKTORIE
trajektorie