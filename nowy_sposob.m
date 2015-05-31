tau = 0:1000*odstep_czasu:czas_symulacji; % Wektor wêz³ów
% tau = [0, sort(randperm(ilosc_punktow_czasu*odstep_czasu-1, 6)), ilosc_punktow_czasu*odstep_czasu];
dtau = diff(tau); % D³ugoœæ przedzia³ów strukuralnych
umax = 1;
u0 = 1; % "Niby" znane sterowanie
h0 = odstep_czasu; % D³ugoœæ kroku metody Rungego-Kutty
n = ceil(dtau/h0)';
cn = cumsum([1;n]);
cn(end) = cn(end) - 1;
xn = zeros(cn(end), length(x0));
xn(1,:) = x0;
t = zeros(cn(end), 1);
ster = zeros(cn(end), 1);

%% Obliczanie równañ ró¿niczkowych
u = u0;
for j = 1:length(dtau) % Pêtla po odcinkach prze³¹czeñ
    h = dtau(j)/n(j);
    h2 = h/2;
    h3 = h/3;
    h6 = h/6;
    for i = cn(j):cn(j+1)-1
        ster(i) = u; % TODO do usuniecia
        % Krok Rungego-Kutty
        z = xn(i, :);
        dx1 = rhs(z, u, parametry);
        dx2 = rhs(z + h2*dx1, u, parametry);
        dx3 = rhs(z + h2*dx2, u, parametry);
        dx4 = rhs(z + h2*dx3, u, parametry);
        z = z + h3 * (dx2 + dx3) + h6 * (dx1 + dx4);
        t(i+1) = t(i) + odstep_czasu;
        xn(i+1, :) = z;
    end
    % Prze³¹czenie sterowania na przeciwne
    u = -u;
end

%% Obliczanie równañ sprzê¿onych
xT = parametry(7);
psi_rozw(cn(end), :)= [2*xT-2*xn(end,1) 0 0 0];

for j = length(dtau):-1:1 % Pêtla po odcinkach prze³¹czeñ
    h = dtau(j)/n(j);
    h2 = h/2;
    h3 = h/3;
    h6 = h/6;
    for i = cn(j+1):-1:cn(j)+1
        z = [xn(i, 1:4) psi_rozw(i, :)];
        dz1 = rhs_a(z, ster(i), parametry);
        dz2 = rhs_a(z - h/2*dz1, ster(i), parametry);
        dz3 = rhs_a(z - h/2*dz2, ster(i), parametry);
        dz4 = rhs_a(z - h*dz3, ster(i), parametry);
        z = z - h/3 * (dz2 + dz3) - h/6 * (dz1 + dz4);
        psi_rozw(i-1, :) = z(5:8);
    end
end

%% Sprawdzanie
epsil = 1e-6;
dQ = zeros(length(x0)-1, 1)';
[Q, xtmp] = cost(x0, tau, u0, umax, h0, czas_symulacji, parametry);
for i = 1:length(x0)-1
    x0_ = x0;
    x0_(i) = x0_(i) + epsil;
    Q_ = cost(x0_, tau, u0, umax, h0, czas_symulacji, parametry);
    dQ(i) = (Q_ - Q)/epsil;
end