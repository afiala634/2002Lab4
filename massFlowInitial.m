function [mri] = massFlowInitial(mb, rhoWat, vb, vair, pair, Tair)
%Equation 12

%Mass of the bottle, density of water, volume of bottle as a function of
%time, volume of air (initial), initial pressure of air, initial
%temperature
Rair = 287;
mri = mb + rhoWat(vb -vair) + (pair/(Rair*Tair)) * vair;