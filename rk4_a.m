function [ z ] = rk4_a(z, u, h, parametry)
%% Rozwi¹zanie sprzê¿onego równania ró¿niczkowego metod¹ Rungego-Kuty (RK4)
dz1 = rhs_a(z, u, parametry);
dz2 = rhs_a(z - h/2*dz1, u, parametry);
dz3 = rhs_a(z - h/2*dz2, u, parametry);
dz4 = rhs_a(z - h*dz3, u, parametry);
z = z - h/3 * (dz2 + dz3) - h/6 * (dz1 + dz4);

end

