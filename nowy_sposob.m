tau = 0:1000*odstep_czasu:ilosc_punktow_czasu*odstep_czasu; % Wektor wêz³ów
dtau = diff(tau); % D³ugoœæ przedzia³ów strukuralnych
u0 = 1; % "Niby" znane sterowanie
h0 = odstep_czasu; % D³ugoœæ kroku metody Rungego-Kutty
n = ceil(dtau/h0)';
cn = cumsum([1;n]);
xn = zeros(cn(end), length(x0));
t = zeros(cn(end), 1);
ster = zeros(cn(end), 1);

%% Obliczanie równañ ró¿niczkowych
for j = 1:length(dtau) % Pêtla po odcinkach prze³¹czeñ
    if mod(j, 2)
        u = u0;
    else
        u = -u0;
    end
    h = dtau(j)/n(j);
    h2 = h/2;
    h3 = h/3;
    h6 = h/6;
    for i = cn(j):cn(j+1)-1
        % Krok Rungego-Kutty
        ster(i) = u;
        z = xn(i, :);
        dx1 = rhs(z, u, m, M, l, g, fp, fc);
        dx2 = rhs(z + h2*dx1, u, m, M, l, g, fp, fc);
        dx3 = rhs(z + h2*dx2, u, m, M, l, g, fp, fc);
        dx4 = rhs(z + h2*dx3, u, m, M, l, g, fp, fc);
        z = z + h3 * (dx2 + dx3) + h6 * (dx1 + dx4);
        t(i+1) = t(i) + odstep_czasu;
        xn(i+1, :) = z;
    end
end

%% Obliczanie równañ sprzê¿onych
psi_rozw(cn(end), :)= [0 0 0 0];
for j = length(dtau):-1:1 % Pêtla po odcinkach prze³¹czeñ
    if mod(j, 2)
        u = u0;
    else
        u = -u0;
    end
    h = dtau(j)/n(j);
    h2 = h/2;
    h3 = h/3;
    h6 = h/6;
    for i = cn(j+1):-1:cn(j)+1
        % Krok Rungego-Kutty
        z = [xn(i, 1:4) psi_rozw(i, :)];
        dz1 = rhs_a(z, u, m, M, l, g, fp, fc);
        dz2 = rhs_a(z - h/2*dz1, u, m, M, l, g, fp, fc);
        dz3 = rhs_a(z - h/2*dz2, u, m, M, l, g, fp, fc);
        dz4 = rhs_a(z - h*dz3, u, m, M, l, g, fp, fc);
        z = z - h/3 * (dz2 + dz3) - h/6 * (dz1 + dz4);
        psi_rozw(i-1, :) = z(5:8);
    end
end

%% Obliczanie gradientu
n = 4;
for j = length(dtau):-1:1 % Pêtla po odcinkach prze³¹czeñ
    z = zeros(1, 2*n+1);
    for i = cn(j+1):-1:cn(j)+1
        z = [xn(i, :) psi_rozw(i, :) z(end)];
        z(end) = z(6)/(m*sin(z(3))^2 + M + fc) - (z(8)*m*cos(z(3)))/((l*m + fp/l)*(m*sin(z(3))^2 + M + fc));
    end
    dQ(j, 1) = z(end);
end

xn(end, :)=[];
x=xn;
u = ster(1:end-1);
t(end)=[];