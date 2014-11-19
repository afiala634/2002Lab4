function [p] = pressEqn3(Vair, vt)
%P is P/Pair, where p is a function of time and Pair is the initial
%condition.  Vair is the initial volume of air, and vt is the volume as a
%function of time.
gamma = 1.4;

    p = (Vair/vt)^gamma;