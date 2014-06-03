u = -u0; % Specjalnie ujemne, zeby na poczaku petli bylo takie, jakie powinno byc
for j = length(dtau):-1:1 % Pêtla po odcinkach prze³¹czeñ
    u = -u;
    h = dtau(j)/n(j);
    h2 = h/2;
    h3 = h/3;
    h6 = h/6;
    z = 0;
    for i = cn(j+1):-1:cn(j)+1
        % Krok Rungego-Kutty
        dz1 = rhs_q(xn(i, 3), psi_rozw(i, 2), psi_rozw(i, 4), m, M, l, fp, fc);
        dz2 = rhs_q(xn(i, 3), psi_rozw(i, 2), psi_rozw(i, 4) - h/2*dz1, m, M, l, fp, fc);
        dz3 = rhs_q(xn(i, 3), psi_rozw(i, 2), psi_rozw(i, 4) - h/2*dz2, m, M, l, fp, fc);
        dz4 = rhs_q(xn(i, 3), psi_rozw(i, 2), psi_rozw(i, 4) - h*dz3, m, M, l, fp, fc);
        z = z - h/3 * (dz2 + dz3) - h/6 * (dz1 + dz4);
%         dQ(i-1) = z;
    end
    dQ(j) = z
end

