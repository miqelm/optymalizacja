u = u0;
for j = 1:length(dtau) % Pêtla po odcinkach prze³¹czeñ
    
    Fi = psi_rozw(cn(j),2)/(m*sin(xn(cn(j),3))^2 + M + fc) - (psi_rozw(cn(j),4)*m*cos(xn(cn(j),3)))/((l*m + fp/l)*(m*sin(xn(cn(j),3))^2 + M + fc));
    dQ(j) = Fi * (-u - u);
    u = -u;
end

dQ= 2 * u0 * Fi(t(cn(2:end-1)));
dQ(2:2:end)=-dQ(;