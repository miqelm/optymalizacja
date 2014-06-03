function Q = cost_dec( u, odstep_czasu, x, m, M, l, g, fp, fc, ilosc_punktow_czasu )

for i = 1:ilosc_punktow_czasu-1
    x = rk4(x, u(i), odstep_czasu, m, M, l, g, fp, fc);
end

Q = x(5);

end

