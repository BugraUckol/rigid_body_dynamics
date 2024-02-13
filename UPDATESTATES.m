function [X_NEW, E_NEW, V_NEW, W_NEW] = UPDATESTATES(X,E,V,W,VD,WD,TS)

    % Transformations
    M_CB2E = CB2E(E);
    ED = W2ED(W, E);

    % 1st Order Explicit Euler Integration

    % Update position and orientation
    X_NEW = X + M_CB2E * V * TS;
    E_NEW = E + ED * TS;

    % Update linear and angular velocity
    V_NEW = V + VD * TS;
    W_NEW = W + WD * TS;

end