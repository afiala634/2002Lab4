function r = bottleEqn(t, y)
h = y(1);
v = y(2);
m = y(3);
if t < 0
    error('Negative time, please  do not break physics')
end
if t >= 0 && t < 0.26
    Ft = 60*t;
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