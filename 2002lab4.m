%2002 Lab 4 Main function:

%for loop for text coefficients
tSpan = [0 15];
[t, y] = ode45('bottleEqn', tspan, [0 0 0.1536]);

figure(fignum)
plot(t, y(:, 1))
title('Time Vs Rocket Trajectory')
xlabel('Time (Sec)')
ylabel('Height (M)')
legend('Rocket Trajectory', 'Location', 'South')

figure(fignum + 1)
plot( t, y(:, 2))
title('Time Vs Rocket Velocity')
xlabel('Time (Sec)')
ylabel('Velocity (m/s)')
legend('Velocity', 'Location', 'South')

figure(fignum + 2)
plot( t, y(:, 3))
title('Time Vs Rocket Mass')
xlabel('Time (Sec)')
ylabel('Mass (kg)')
legend('Mass', 'Location', 'South')

[peaks, loc] = findpeaks(y(:, 1));
tindex = t(loc);
maxHeight = peaks(1);