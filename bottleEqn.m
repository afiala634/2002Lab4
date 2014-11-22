function r = bottleEqn(t, y)

%Variable declaration:
Pamb = 8.2960e+04; %ambiant pressure calculated by standard atmo
At = .00038 ; %Area of throat M^2
vb = .002; %volume of bottle m^3
WaterRho = 1000; %kg/m^3
Pnot = 690000;  %Initial pressure pascals
R = 287 %J/kg*k gas constant
To = 277.3925; %initial temperature from standard atmo
mair0 = Pnot*((2/3)*.002)/(R*T0); %Change the 2/3 later



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
    Tend = ?
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
        Isp = F/mdotair;
    elseif pcrit <= pa
        M = sqrt(((((p/pa)^((gamma-1)/gamma)) - 1)*2)/(gamma -1));
        Te = T*(1 + ((gamma - 1)/2)*M^2);
        Rhoe = Pa/(R*Te);
        Ve = M*sqrt(gamma*R*Te);
         mdotair = cd*Rhoe*At*Ve; %mass flow of air
         F = mdotair*Ve + (pe - pa)*At; %Thrust
         Isp = F/mdotair;
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