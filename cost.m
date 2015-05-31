function [ Q, xres ] = cost( x0, tau, u0, umax, h0, tf, parametry )
%Zwraca wartoœæ funkcji kosztu.

if size(tau, 1) == 1
    tau = tau';
end
if tau(1) ~= 0 && tau(end) ~= tf
    dtau = diff([0; tau; tf]);
else
    dtau = diff(tau);
end
N    = ceil(dtau./h0);
cn   = cumsum([1; N]);
xtmp = x0;
u    = zeros(length(dtau), 1);

if u0 == umax
    u(1:2:end) = u0;
    u(2:2:end) = -u0;
else
    u(1:2:end) = -umax;
    u(2:2:end) = umax;
end

aaa=1;
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
        xres(aaa, :)=xtmp;
        aaa= aaa+1;
    end
end

xT = parametry.xT;
Q = xtmp(5) + (xT - xtmp(1))^2;
end

