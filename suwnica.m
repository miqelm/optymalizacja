%% MAIN
clear all;
close all;
format long e

%% Sta³e
parametry.m = 0.192; % m
parametry.M = 0.604; % M
parametry.l = 0.165; % l
parametry.g = 9.81;  % g
parametry.fc = 1;  % fc
parametry.xT = 1;     % xT

%% Parametry symulacji
czas_symulacji = 5;
odstep_czasu = 0.01;
ilosc_przelaczen = 30;

%% WARUNKI POCZ¥TKOWE
x0 = 0;
xprim0 = 0;
theta0 = 0;
thetaprim0 = 0;
x0 = [x0 xprim0 theta0 thetaprim0 0];

%% Optymalizacja sterowania metod¹ BFGS
tau = linspace(0, czas_symulacji, ilosc_przelaczen + 2)';
tau = tau(2:end-1);

umax = 1;
u0 = umax;
e0 = 1e-6;
[t, x, xmin, u0] = BFGS(tau, x0, odstep_czasu, parametry, czas_symulacji, umax, u0);
display('Otrzymane rozwi¹zanie');
x=x';
xmin
u0

%% TRAJEKTORIE
trajektorie