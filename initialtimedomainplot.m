% Plot vin and vout versus time
figure
plot(t, vin, 'LineWidth', 1.5)
hold on
plot(t, vout, 'LineWidth', 1.5)
hold off

grid on
xlabel('Time')
ylabel('Voltage')
legend('vin', 'vout', 'Location', 'best')
title('Vin and Vout vs Time')
