function [X_NEW, E_NEW, V_NEW, W_NEW] = PARALLELRK4UPDATESTATES(m,P_j,P_j_i,P_F,P_M,P_X,P_E,P_V,P_W,TS)

% Function Definitions
f1 = @(m,j,j_i,F,M,X,E,V,W) VE_PARALLEL(E, V);
f2 = @(m,j,j_i,F,M,X,E,V,W) W2ED_PARALLEL(W, E);
f3 = @(m,j,j_i,F,M,X,E,V,W) VBD_PARALLEL(m, F, V, W);
f4 = @(m,j,j_i,F,M,X,E,V,W) WBD_PARALLEL(j, j_i, W, M);

% 4th Order Explicit Runge Kutta Integration
[X_NEW, E_NEW, V_NEW, W_NEW] = RK4(m,P_j,P_j_i,P_F,P_M,P_X,P_E,P_V,P_W,TS,f1,f2,f3,f4);

end
