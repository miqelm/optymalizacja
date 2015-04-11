%% MAIN
% clear all;
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
% nowy_sposob
% x = xn;
% u = ster;
% wyliczone = psi_rozw(1, :)
% sprawdzone = -dQ
%% OBLICZENIA
% [x, psi_rozw, dQ, t] = rozwiaz_uklad(u, odstep_czasu, x0, parametry, ilosc_punktow_czasu);

% wyliczone = psi_rozw(1, :)
% sprawdzone = -dQ(1:4)'

%Testowanie dzia³ania metody BFGS
a = parametry;
%Pierwszy zestaw parametrów X00 = [1 4.6 0.1 25]; % X S P V
% X00 = [1 1 0.1 25];
X00 = x0(1:4);
Tk = czas_symulacji;
h0 = odstep_czasu;
tau = linspace(0, Tk, 100)';
tau = tau(2:end-1);

umax = 1;
u0 = umax;
e0 = 1e-6;
[t, ~, ~, H, xmin, u0] = BFGS(tau, X00, h0, a, Tk, umax, u0);
display('Otrzymane rozwi¹zanie');
xmin
u0


%% TRAJEKTORIE
trajektorie