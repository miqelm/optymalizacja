function [ Q ] = cost( x0, tau, u0, umax, h0, tf, a )
%Zwraca wartoœæ funkcji kosztu.

dtau = diff([0; tau; tf]);
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
        dx1=rhs(xtmp, u(j), a);
        dx2=rhs(xtmp+h_2*dx1, u(j), a);
        dx3=rhs(xtmp+h_2*dx2, u(j), a);
        dx4=rhs(xtmp+h*dx3, u(j), a);
        xtmp=xtmp+h_6*(dx1+dx4)+h_3*(dx2+dx3);
        xres(aaa, :)=xtmp;
        aaa= aaa+1;
    end
end
% Q = x0(3)*x0(4)-xtmp(3)*xtmp(4);
xT = a(7);
suma=sum(abs(xres(:, 3)))
Q = xtmp(5) + (xT - xtmp(1))^2;
end

