function [X_NEW, E_NEW, V_NEW, W_NEW] = RK4UPDATESTATES(m,j,j_i,F,M,X,E,...
    V,W,TS)

% Function Definitions
f1 = @(m,j,j_i,F,M,X,E,V,W) CB2E(E) * V;
f2 = @(m,j,j_i,F,M,X,E,V,W) W2ED(W, E);
f3 = @(m,j,j_i,F,M,X,E,V,W) F / m - cross(W, V);
f4 = @(m,j,j_i,F,M,X,E,V,W) j_i * (M - cross(W, j * W));

% 4th Order Explicit Runge Kutta Integration
[X_NEW, E_NEW, V_NEW, W_NEW] = RK4(m,j,j_i,F,M,X,E,V,W,TS,f1,f2,f3,f4);

end