function [t, x, psi, dQ, H1] = gradient(x0, tau, u0, umax, h0, tf, parametry)
%Wyliczanie rozwi¹zania metod¹ Rungego-Kuty 4-go rzêdu od ty³u.

dtau = diff([0; tau; tf]);
N    = ceil(dtau./h0);
cn   = cumsum([1; N]);
n        = length(x0);
x        = zeros(n, cn(end));
psi      = zeros(n-1, cn(end));
H1       = zeros(1, cn(end));
xtmp     = x0;
x(:, 1)  = x0;
t        = zeros(1, cn(end));
t(end)   = tf;
dQ       = zeros(length(dtau), 1);
u        = zeros(length(dtau), 1);
if u0 == umax
    u(1:2:end) = u0;
    u(2:2:end) = -u0;
else
    u(1:2:end) = -umax;
    u(2:2:end) = umax;
end
p = u(end) - u(end-1);

m = parametry.m;
M = parametry.M;
l = parametry.l;

%Ca³kowanie równañ stanu.
for j = 1:length(dtau)
    h = dtau(j)/N(j);
    h_2 = h/2;
    h_6 = h/6;
    h_3 = 2*h_6;    
    for i = cn(j):cn(j+1)-1
        dx1=rhs(xtmp, u(j), parametry);
        dx2=rhs(xtmp+h_2*dx1, u(j), parametry);
        dx3=rhs(xtmp+h_2*dx2, u(j), parametry);
        dx4=rhs(xtmp+h*dx3, u(j), parametry);
        xtmp=xtmp+h_6*(dx1+dx4)+h_3*(dx2+dx3);
        t(i+1)  = t(i)+h;
        x(:,i+1)= xtmp;
    end
end

%Ca³kowanie równañ sprzê¿onych.
psi(:,end)  = [2*parametry.xT-2*x(1, end) 0 0 0];
for j = length(dtau):-1:1
    h   = dtau(j)/N(j);
    h_2 = h/2;
    h_6 = h/6;
    h_3 = 2*h_6;
    
    for i = cn(j+1):-1:cn(j)+1
       ztmp = [x(1:4, i)' psi(:, i)'];
       dz1=rhs_a(ztmp, u(j), parametry); 
       dz2=rhs_a(ztmp-h_2*dz1, u(j), parametry);
       dz3=rhs_a(ztmp-h_2*dz2, u(j), parametry);
       dz4=rhs_a(ztmp-h*dz3, u(j), parametry);
       ztmp=ztmp-h_6*(dz1+dz4)-h_3*(dz2+dz3);
       psi(:, i-1) = ztmp(5:end); 
       H1(1, i-1) = dz1(end);
    end
    dQ(j) = (psi(2, cn(j))/(m*sin(x(3, cn(j)))^2 + M) - (psi(4, cn(j))*cos(x(3, cn(j))))/(l*(m*sin(x(3, cn(j)))^2 + M))) * p;
    p     = -p;
end
dQ = dQ(2:end);

%% Sprawdzanie
% oryginal_dQ = dQ;
% epsil = 1e-6;
% dec = tau;
% dQ = zeros(length(dec), 1)';
% [Q, xtmp] = cost(x0, dec, u0, umax, h0, tf, a);
% for i = 1:length(dec)
%     dec_ = dec;
%     dec_(i) = dec_(i) + epsil;
%     Q_ = cost(x0, dec_, u0, umax, h0, tf, a);
%     dQ(i) = (Q_ - Q)/epsil;
% end
% dQ = dQ'
% oryginal_dQ
% dQ ./ oryginal_dQ

