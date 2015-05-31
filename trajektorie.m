x1 = x(:, 1);
x2 = x(:, 2);
theta1 = x(:, 3);
theta2 = x(:, 4);
figure
subplot(3, 2, 1)
plot(t, x1)
xlabel('Czas [s]')
ylabel('Odleg³oœæ [m]')
title(sprintf('Po³o¿enie (x(0) = %.2f m)', x0(1)))
hold on
plot(t, parametry.xT, 'r')
legend('Po³o¿enie [m]', 'Zadane po³o¿enie koñcowe [m]')
subplot(3, 2, 2)
plot(t, x2)
xlabel('Czas [s]')
ylabel('Prêdkoœæ [m/s]')
title(sprintf('Prêdkoœæ (x''(0) = %.2f m/s)', x0(2)))
subplot(3, 2, 3)
plot(t, (theta1*180/pi))
xlabel('Czas [s]')
ylabel(sprintf('Wychylenie [%c]', 176))
title(sprintf('Wychylenie (Theta(0) = %.2f%c)', x0(3)*180/pi, 176))
subplot(3, 2, 4)
plot(t, (theta2*180/pi))
xlabel('Czas [s]')
ylabel(sprintf('Prêdkoœæ [%c/s]', 176))
title(sprintf('Prêdkoœæ k¹towa (Theta''(0) = %.2f %c/s)', x0(4)*180/pi, 176))
subplot(3, 2, [5 6])

u = zeros(size(t));
dtau = diff([0; xmin; czas_symulacji]);
N    = ceil(dtau./odstep_czasu);
cn   = cumsum([1; N]);
ster = u0;
u(1) = u0;
for j = 1:length(dtau)
    u(cn(j)+1:cn(j+1)) = ster;
    ster = -ster;
end

plot(t, u, ':')
lim = abs(u0) * 1.5;
ylim([-lim lim])
xlabel('Czas [s]')
ylabel('Sterowanie')
title('Sterowanie u')