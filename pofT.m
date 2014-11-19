function [P] = pofT(Pnot, Vnot, Voft)
gamma = 1.4;
P = Pnot(Vnot/Voft)^gamma;