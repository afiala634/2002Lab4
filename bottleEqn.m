function r = bottleEqn(t, y)

%Variable declaration:
Pamb = 0; %ambiant pressure
At = 0; %Area of throat
vb = 0; %volume of bottle
WaterRho = 1000; %kg/m^3
Pnot = 0;  %Initial pressure
R = 287 %J/kg*k gas constant




h = y(1);
v = y(2);
m = y(3);
if t< 0
    error('Negative time, please do not break physics')
end


%Phase 1:

if v < vb
    p = p0*((v0/v)^gamma);
    Ft = 2*cd*(Pnot-Pamb)*At;
    Isp = (1/9.81)*sqrt((2*(Pnot-Pamb))/WaterRho);
    
% Phase 2
elseif v = vb && p<pa
    pend = ?
    p = pend*((mair/mair0)^(gamma));
    Rho = mair/vb;
    T = p/(Rho*R);
    pcrit = p*((2/(gamma + 1))^(gamma/(gamma -1)));
    if pcrit > pa
        Te = (2/(gamma+1))*T;
        Rhoe = pcrit/(T*Te);
        Ve = sqrt(gamma*R*Te)
        mdotair = cd*Rhoe*At*Ve; %mass flow of air
        F = mdotair*Ve + (pend - pa)*At; %Thrust
    elseif pcrit <= pa
        M = sqrt(((((p/pa)^((gamma-1)/gamma)) - 1)*2)/(gamma -1));
        Te = T*(1 + ((gamma - 1)/2)*M^2);
        Rhoe = Pa/(R*Te);
        Ve = M*sqrt(gamma*R*Te);
         mdotair = cd*Rhoe*At*Ve; %mass flow of air
         F = mdotair*Ve + (pend - pa)*At; %Thrust
    end
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