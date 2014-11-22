function r = bottleEqn(t, y)

%Variable declaration:
Pamb = 0; %ambiant pressure
At = 0; %Area of throat
vb = 0; %volume of bottle
WaterRho = 1000; %kg/m^3
Pnot = 0;  %Initial pressure






h = y(1);
v = y(2);
m = y(3);
if t< 0
    error('Negative time, please do not break physics')
end


%Equation 1:

if v 
    Ft = 2*cd*(P-Pa)*At;
    Isp = (1/9.81)*sqrt((2*(P-Pa))/WaterRho);
elseif t>=0.26 && t< 1.65
    Ft = 15;
else
    Ft = 0;
end

r(1) = v;
r(2) = (Ft/m) -9.81 - ((0.000626/m)* sign(v) * v^2);
if t< 1.65
r(3) = -0.01515;
else
    r(3) = 0;
end
r = r';
end