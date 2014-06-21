function [ z ] = rk4(z, u, h, parametry)
%% Rozwi¹zanie równania ró¿niczkowego metod¹ Rungego-Kuty (RK4)
dx1 = rhs(z, u, parametry);
dx2 = rhs(z + h/2*dx1, u, parametry);
dx3 = rhs(z + h/2*dx2, u, parametry);
dx4 = rhs(z + h/2*dx3, u, parametry);
z = z + h/3 * (dx2 + dx3) + h/6 * (dx1 + dx4);

end

