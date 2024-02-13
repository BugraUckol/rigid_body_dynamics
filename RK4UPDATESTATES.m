function [X_NEW, E_NEW, V_NEW, W_NEW] = RK4UPDATESTATES(X,E,V,W,VD,WD,TS)

    % Newton-Euler
    [VD, WD] = NEULER(m,j,j_i,F,M,V,W);

    % Transformations
    M_CB2E = CB2E(E);
    ED = W2ED(W, E);

    % 4th Order Explicit Runge Kutta Integration

    [X_NEW, E_NEW, V_NEW, W_NEW] = RK4(X,E,V,W,TS,f1,f2,f3,f4);
    

end