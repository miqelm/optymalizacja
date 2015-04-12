x1 = x(:, 1);
x2 = x(:, 2);
theta1 = x(:, 3);
theta2 = x(:, 4);
figure
subplot(3, 2, 1)
plot(t, x1)
xlabel('Czas [s]')
ylabel('Odleg�o�� [m]')
title(sprintf('Po�o�enie (x(0) = %.2f m)', x0(1)))
subplot(3, 2, 2)
plot(t, x2)
xlabel('Czas [s]')
ylabel('Pr�dko�� [m/s]')
title(sprintf('Pr�dko�� (x''(0) = %.2f m/s)', x0(2)))
subplot(3, 2, 3)
plot(t, (theta1*180/pi))
xlabel('Czas [s]')
ylabel(sprintf('Wychylenie [%c]', 176))
title(sprintf('Wychylenie (Theta(0) = %.2f%c)', x0(3)*180/pi, 176))
subplot(3, 2, 4)
plot(t, (theta2*180/pi))
xlabel('Czas [s]')
ylabel(sprintf('Pr�dko�� [%c/s]', 176))
title(sprintf('Pr�dko�� k�towa (Theta''(0) = %.2f %c/s)', x0(4)*180/pi, 176))
subplot(3, 2, [5 6])

u=[];
% xmin = [0; xmin];
ster = u0;
it = 1;
i = 1
while i <= length(t)
    if abs(t(i) - xmin(it)) < odstep_czasu/2
        ster = -ster;
        if it < length(xmin)
            it = it+1;
        end
        if xmin(it-1) == xmin(it)
            continue
        end
    end
    u(i) = ster;
    i = i + 1;
end
% indeksy = find(t>xmin(end));
% u(indeksy) = -ster;

plot(t, u)
xlabel('Czas [s]')
ylabel('Sterowanie')
title('Sterowanie u')