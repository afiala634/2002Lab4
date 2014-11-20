function [mr] = masschange(cd, at, rhoWat, p, pamb)

%Equation 11

%Inputs:
%Discharge Coef, Area of throat, rho of water, pressure as function of
%time, ambient air pressure


mr = -cd * at * sqrt(2 * rhoWat * (p - pamb));