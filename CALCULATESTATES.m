function [X_NEW,E_NEW,V_NEW,W_NEW] = ...
    CALCULATESTATES(m,j,j_i,F,M,X,E,V,W,TS)

% Newton-Euler equations
[VD, WD] = NEULER(m,j,j_i,F,M,V,W);

% Updating states
[X_NEW, E_NEW, V_NEW, W_NEW] = UPDATESTATES(X,E,V,W,VD,WD,TS);

end