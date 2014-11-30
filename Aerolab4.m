%2002 Lab 4 Main function:

global pAmb aT vB rhoW pNot R tO mAir0 rhoA;

pAmb = 8.2960e+04; %ambiant pressure calculated by standard atmo
aT = .00038 ; %Area of throat M^2
vB = .002; %volume of bottle m^3
rhoW = 1000; %kg/m^3
pNot = 690000;  %Initial pressure pascals
R = 287; %J/kg*k gas constant
tO = 277.3925; %initial temperature from standard atmo
mAir0 = Pnot*((2/3)*.002)/(R*T0); %Change the 2/3 later
rhoA = 666;

tspan1 = [0 30];
[t, y] = ode45('volEqn', tspan1, .002);

%for loop for text coefficients
% tSpan = [0 15];
% [t, y] = ode45('bottleEqn', tspan, [0 0 0.1536]);
% 
% figure(fignum)
% plot(t, y(:, 1))
% title('Time Vs Rocket Trajectory')
% xlabel('Time (Sec)')
% ylabel('Height (M)')
% legend('Rocket Trajectory', 'Location', 'South')
% 
% figure(fignum + 1)
% plot( t, y(:, 2))
% title('Time Vs Rocket Velocity')
% xlabel('Time (Sec)')
% ylabel('Velocity (m/s)')
% legend('Velocity', 'Location', 'South')
% 
% figure(fignum + 2)
% plot( t, y(:, 3))
% title('Time Vs Rocket Mass')
% xlabel('Time (Sec)')
% ylabel('Mass (kg)')
% legend('Mass', 'Location', 'South')
% 
% [peaks, loc] = findpeaks(y(:, 1));
% tindex = t(loc);
% maxHeight = peaks(1);