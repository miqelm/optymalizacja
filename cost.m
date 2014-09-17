function Q = cost( u, odstep_czasu, x, parametry, ilosc_punktow_czasu )

for i = 1:ilosc_punktow_czasu-1
    x = rk4(x, u(i), odstep_czasu, parametry);
end
xT = parametry(7);
Q = x(5) + (xT - x(1))^2;

end

