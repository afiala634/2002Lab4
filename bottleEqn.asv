function dRdt = bottleEqn(t, r)

%% Variable declaration:
global pAmb aT vB rhoW pNot R tO mAir0 rhoA cD rho gamma cd vAir aB test mb

%Unpack variables:
V = r(1);%velocity
theta = r(2);%theta
x = r(3);
z = r(4);
v = r(5);%volume of air
m = r(6);%mass of rocket
mAir = r(7);%mass of air

D = rhoA/2*V^2*cd*aB;%Drag
F = 2*cD*(pNot-pAmb)*aT;%Force
g = -9.81; 

%% Declare Results that Do not depend on conditional
%Velocity
dVdt = (F - D - m* g *sin(theta))/m;
%Theta
if v > 1
dthetadt = (-g*cos(theta))/V;
else 
    dthetadt(2) = 0;
end
%X
dxdt = V*cos(theta);
%z
dzdt = V*sin(theta);
%Volume Result

%Volume Check
if v >= vB
    v = vB;
end

%Mass Check:
if m < mb
    m = mb;
end

%theta check
if sqrt(x^2 + z^2) <.3
    dthetadt = 0;
else
    dthetadt = -9.8*cos(theta) / V;
end

%Variable declaration:
pend = pNot*(vAir/vB)^gamma;
P = pend*((mAir/mAir0)^(gamma));  %mair == m?

%Create new variable for vol water
volWater = vB - v;
if volWater < 0
    volWater = 0;
end




%Check time val
if t< 0
    error('Negative time, please do not break physics')
end


%% Phase 1:

if volWater > 0
   %Volume
    dVoldt = cD*aT*sqrt((2/rhoW) * (pNot * ((v/(vB/3))^gamma) - pAmb));
    dmdt = -cD*aT*sqrt(2*rhoW * (pNot - pAmb));%Mass flow stage 1
    F = 2*cD*(P-pAmb)*aT;
    dmAirdt = 0;
   
    %p = p0*((v0/v)^gamma);
    %Isp = (1/9.81)*sqrt((2*(pNot-pAmb))/rhoW);

 
%% Phase 2
elseif P > pAmb %v >= vB %&& 
    
 
    %Tend = aT(vAir/vB)^(gamma-1);
   
    Rho = mAir/vB;
    T = P/(Rho*R);
    pcrit = P*((2/(gamma + 1))^(gamma/(gamma -1)));
    if pcrit > pAmb                 %pa = pamb?
        Te = (2/(gamma+1))*T;
        Rhoe = pcrit/(R*Te);
        Ve = sqrt(gamma*R*Te); 
        pe = pcrit;
        %Isp = F/mdotair;
    elseif pcrit <= pAmb
        M = sqrt(((((P/pAmb)^((gamma-1)/gamma)) - 1)*2)/(gamma -1));
        Te = T*(1 + ((gamma - 1)/2)*M^2);
        Rhoe = pAmb/(R*Te);
        Ve = M*sqrt(gamma*R*Te);
        pe = pAmb;
        %Isp = F/mdotair;
    end
    dVoldt = 0;
    dmdt = -cD*Rhoe*aT*(Ve^2);
    dmAirdt = dmdt;
    mdotair = cd*Rhoe*aT*Ve; %mass flow of air
    F = mdotair*Ve + (pe - pAmb)*aT; %Thrust
    
   
%% Phase 3
else
    dVoldt = 0;
    dmdt = 0;
    F = 0;
    dmAirdt = 0;
    %Ft = 0;
end

dRdt(1) = dVdt;
dRdt(2) = dthetadt;
dRdt(3) = dxdt;
dRdt(4) = dzdt;
dRdt(5) = dVoldt;
dRdt(6) = dmdt;
dRdt(7) = dmAirdt;
dRdt = dRdt';
end