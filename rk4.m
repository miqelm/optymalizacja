function [ z ] = rk4(z, u, h, m, M, l, g, fp, fc)
%% Rozwi¹zanie równania ró¿niczkowego metod¹ Rungego-Kuty (RK4)
dx1 = rhs(z, u, m, M, l, g, fp, fc);
dx2 = rhs(z + h/2*dx1, u, m, M, l, g, fp, fc);
dx3 = rhs(z + h/2*dx2, u, m, M, l, g, fp, fc);
dx4 = rhs(z + h/2*dx3, u, m, M, l, g, fp, fc);
z = z + h/3 * (dx2 + dx3) + h/6 * (dx1 + dx4);

end

