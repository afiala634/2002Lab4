%2002 Lab 4 Main function:
clc
clear all
close all

global pAmb aT vB rhoW pNot R tO mAir0 rhoA cD rho gamma cd vAir aB test mb

[a, b, c, d] = atmoscoesa(5300);
pAmb = 8.2960e+04; %ambiant pressure calculated by standard atmo
aT = .00038 ; %Area of throat M^2
vB = .002; %volume of bottle m^3
rhoW = 1000; %kg/m^3
pNot = 360000;  %Initial pressure pascals
R = 287; %J/kg*k gas constant
vAir = (2/3) * vB;
tO = 277.3925; %initial temperature from standard atmo
mAir0 = (pNot /R / tO) * vAir; %Change the 2/3 later
rhoA = 1.04186;%Density from standard atmosphere
cD = .9; %discharge coef
rho = a;
gamma = 1.4;
cd = .3; %drag coef

aB = pi*(.05^2);
test = zeros(1);
mb = 0.15; %kg

mrIni = mb + rhoW * (vB - vAir) + ( pNot/(R * tO)) * vAir;

tspan1 = [0 30];
[t, y] = ode45('bottleEqn', tspan1, [0, (pi/4), 0, 0.1, vAir, 1.15, .0044] );

%for loop for text coefficients
% tSpan = [0 15];
% [t, y] = ode45('bottleEqn', tspan, [0 0 0.1536]);
% 
fignum = 1;
figure(fignum)
plot(t, y(:, 1))
title('Velocity')
xlabel('Time (Sec)')
ylabel('Height (M)')
%legend('Rocket Trajectory', 'Location', 'South')

figure(fignum + 1)
plot( t, y(:, 2))
title('theta')
xlabel('Time (Sec)')
ylabel('Velocity (m/s)')
%legend('Velocity', 'Location', 'South')

figure(fignum + 2)
plot( t, y(:, 3))
title('x')
xlabel('Time (Sec)')
ylabel('Mass (kg)')
legend('Mass', 'Location', 'South')

figure(fignum + 3)
plot(t, y(:, 4))
title('z')

figure(fignum + 4)
plot(t, y(:, 5))
title('v')


figure(fignum + 5)
plot(t, y(:, 6))
title('m')
% 
% [peaks, loc] = findpeaks(y(:, 1));
% tindex = t(loc);
% maxHeight = peaks(1);