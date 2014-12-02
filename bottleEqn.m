function dRdt = bottleEqn(t, r)

%% Variable declaration:
global pAmb aT vB rhoW pNot R tO mAir0 rhoA cD rho gamma cd vAir aB test;

%Unpack variables:
V = r(1);%velocity
theta = r(2);%theta
x = r(3);
z = r(4);
v = r(5);%volume
m = r(6);%mass of rocket

D = rhoA/2*V^2*cd*aB;%Drag
F = 2*cD*(pNot-pAmb)*aT;%Force
g = -9.81; 

%% Declare Results that Do not depend on conditional
%Velocity
dRdt(1) = (F - D - m* g *sin(theta))/m;
%Theta
if v > 1
dRdt(2) = (-g*cos(theta))/V;
else 
    dRdt(2) = 0;
end
%X
dRdt(3) = V*cos(theta);
%z
dRdt(4) = V*sin(theta);
%Volume Result

test = v;

dRdt(5) = cD*aT*sqrt((2/rhoW) * (pNot * ((v/(vB/3))^gamma) - pAmb));

%Check time val
if t< 0
    error('Negative time, please do not break physics')
end


%% Phase 1:

if v < vB
    dRdt(6) = -cD*aT*sqrt(2*rhoW * (pNot - pAmb));%Mass flow stage 1
    %p = p0*((v0/v)^gamma);
    
    %Isp = (1/9.81)*sqrt((2*(pNot-pAmb))/rhoW);

    
%% Phase 2
elseif v >= vB %&& p < pa
     tE = (2/(gamma + 1)) * aT;
     rhoE = pAmb/(R * tE);
     
    pend = pNot*(vAir/vB)^gamma;
    %Tend = aT(vAir/vB)^(gamma-1);
    p = pend*((m/mAir0)^(gamma));  %mair == m?
    Rho = m/vB;
    T = p/(Rho*R);
    pcrit = p*((2/(gamma + 1))^(gamma/(gamma -1)));
    if pcrit > pAmb                 %pa = pamb?
        Te = (2/(gamma+1))*T;
        Rhoe = pcrit/(T*Te);
        Ve = sqrt(gamma*R*Te); 
        pe = pcrit;
        %Isp = F/mdotair;
    elseif pcrit <= pAmb
        M = sqrt(((((p/pAmb)^((gamma-1)/gamma)) - 1)*2)/(gamma -1));
        Te = T*(1 + ((gamma - 1)/2)*M^2);
        Rhoe = pAmb/(R*Te);
        Ve = M*sqrt(gamma*R*Te);
        pe = pAmb;
        %Isp = F/mdotair;
    end
    dRdt(5) = 0;
    dRdt(6) = -cD*rhoE*aT*Ve;
    mdotair = cd*Rhoe*aT*Ve; %mass flow of air
    F = mdotair*Ve + (pend - pAmb)*aT; %Thrust
    
   
%% Phase 3
else
    dRdt(6) = 0;
    dRdt(5) = 0;
    F = 0;
    %Ft = 0;
end

dRdt = dRdt';
end