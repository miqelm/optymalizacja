function [t, x, psi, dQ, H1, epsil] = gradient(x0, tau, u0, umax, h0, tf, a)
%Wyliczanie rozwi¹zania metod¹ Rungego-Kuty 4-go rzêdu od ty³u.

dtau = diff([0; tau; tf]);
N    = ceil(dtau./h0);
cn   = cumsum([1; N]);
%cn
%u0
n        = length(x0);
ui       = zeros(1, cn(end));
x        = zeros(n, cn(end));
psi      = zeros(n-1, cn(end));
H1       = zeros(1, cn(end));
xtmp     = x0;
x(:, 1)  = x0;
t        = zeros(1, cn(end));
t(end)   = tf;
dQ       = zeros(length(dtau), 1);
u        = zeros(length(dtau), 1);
epsil    = 0;
if u0 == umax
    u(1:2:end) = u0;
    u(2:2:end) = -u0;
else
    u(1:2:end) = -umax;
    u(2:2:end) = umax;
end
p = u(end) - u(end-1);

%Ca³kowanie równañ stanu.
for j = 1:length(dtau)
    h = dtau(j)/N(j);
    h_2 = h/2;
    h_6 = h/6;
    h_3 = 2*h_6;    
    for i = cn(j):cn(j+1)-1
        dx1=rhs(xtmp, u(j), a);
        dx2=rhs(xtmp+h_2*dx1, u(j), a);
        dx3=rhs(xtmp+h_2*dx2, u(j), a);
        dx4=rhs(xtmp+h*dx3, u(j), a);
        xtmp=xtmp+h_6*(dx1+dx4)+h_3*(dx2+dx3);
        t(i+1)  = t(i)+h;
        x(:,i+1)= xtmp;
    end
end

%Ca³kowanie równañ sprzê¿onych.
psi(:,end)  = [2*a(7)-2*x(1, end) 0 0 0];
for j = length(dtau):-1:1
    h   = dtau(j)/N(j);
    h_2 = h/2;
    h_6 = h/6;
    h_3 = 2*h_6;
    
    for i = cn(j+1):-1:cn(j)+1
       ztmp = [x(1:4, i)' psi(:, i)'];
       dz1=rhs_a(ztmp, u(j), a); 
       dz2=rhs_a(ztmp-h_2*dz1, u(j), a);
       dz3=rhs_a(ztmp-h_2*dz2, u(j), a);
       dz4=rhs_a(ztmp-h*dz3, u(j), a);
       ztmp=ztmp-h_6*(dz1+dz4)-h_3*(dz2+dz3);
       psi(:, i-1) = ztmp(5:end); 
       psi(end, i-1) = dz1(end);
       H1(1, i-1) = dz1(end);
    end
    dQ(j) = psi(end, cn(j))*p;
    epsil = epsil + H1(1, cn(j))^2;
    p     = -p;
end
epsil = epsil - H1(1, 1)^2;
dQ = dQ(2:end);
end

