function Q = cost( u, odstep_czasu, x, parametry, ilosc_punktow_czasu )

for i = 1:ilosc_punktow_czasu-1
    x = rk4(x, u(i), odstep_czasu, parametry);
end

Q = x(5);

end

