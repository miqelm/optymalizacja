%% MAIN
clear all;
close all;
format compact
format long e
stale

%% WARUNKI POCZ¥TKOWE
x0 = 0;
xprim0 = 0;
theta0 = 0;
thetaprim0 = 0;
x0 = [x0 xprim0 theta0 thetaprim0 0];

%% Nowy sposób
nowy_sposob
x = xn;
u = ster;
wyliczone = psi_rozw(1, :)
sprawdzone = -dQ
%% OBLICZENIA
% [x, psi_rozw, dQ, t] = rozwiaz_uklad(u, odstep_czasu, x0, parametry, ilosc_punktow_czasu);
% 
% wyliczone = psi_rozw(1, :)
% sprawdzone = -dQ(1:4)'

%% TRAJEKTORIE
trajektorie