function dRdt = bottleEqn(t, r)

%Variable declaration:
global pAmb aT vB rhoW pNot R tO mAir0 rhoA;

V = r(1);
theta = r(2);
x = r(3);
z = r(4);
v = r(5);
m = r(6);

D = rhoA/2*V^2*cD*aR;

dRdt(1) = (F - D - mR*gO*sin(theta))/mR;
dRdt(2) = (-gO*cos(theta))/V;
dRdt(3) = V*cos(theta);
dRdt(4) = V*sin(theta);
dRdt(6) = cD*aT*sqrt(2/rhoW(rhoNot(vNot/v)^gamma - pA));

if t< 0
    error('Negative time, please do not break physics')
end


%Phase 1:

if v < vB
    dRdt(6) = -cD*aT*sqrt(2*rhoW(rho - rhoW));
    p = p0*((v0/v)^gamma);
    Ft = 2*cd*(pNot-pAmb)*aT;
    Isp = (1/9.81)*sqrt((2*(pNot-pAmb))/rhoW);
    
% Phase 2
elseif v == vB && p < pa
    dRdt(6) = cD*rhoE*aT*vE;
    pend = pAirIn(vAirIn/vB)^gamma;
    Tend = TAirIn(vAirIn/vB)^(gamma-1);
    p = pend*((mair/mAir0)^(gamma));
    Rho = mair/vB;
    T = p/(Rho*R);
    pcrit = p*((2/(gamma + 1))^(gamma/(gamma -1)));
    if pcrit > pa
        Te = (2/(gamma+1))*T;
        Rhoe = pcrit/(T*Te);
        Ve = sqrt(gamma*R*Te);
        mdotair = cd*Rhoe*aT*Ve; %mass flow of air
        F = mdotair*Ve + (pend - pa)*aT; %Thrust
        Isp = F/mdotair;
    elseif pcrit <= pa
        M = sqrt(((((p/pa)^((gamma-1)/gamma)) - 1)*2)/(gamma -1));
        Te = T*(1 + ((gamma - 1)/2)*M^2);
        Rhoe = Pa/(R*Te);
        Ve = M*sqrt(gamma*R*Te);
         mdotair = cd*Rhoe*aT*Ve; %mass flow of air
         F = mdotair*Ve + (pe - pa)*aT; %Thrust
         Isp = F/mdotair;
    end
else
    dRdt(6) = 0;
    Ft = 0;
end

dRdt = dRdt';
end