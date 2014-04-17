function [ z ] = rk4_a(z, u, h, m, M, l, g, fp, fc)
%% Rozwi�zanie sprz�onego r�wnania r�niczkowego metod� Rungego-Kuty (RK4)
dz1 = rhs_a(z, u, m, M, l, g, fp, fc);
dz2 = rhs_a(z - h/2*dz1, u, m, M, l, g, fp, fc);
dz3 = rhs_a(z - h/2*dz2, u, m, M, l, g, fp, fc);
dz4 = rhs_a(z - h*dz3, u, m, M, l, g, fp, fc);
z = z - h/3 * (dz2 + dz3) - h/6 * (dz1 + dz4);

end

