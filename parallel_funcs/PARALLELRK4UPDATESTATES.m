function [X_NEW, E_NEW, V_NEW, W_NEW] = PARALLELRK4UPDATESTATES(P_CB2E,P_W2ED,m,P_j,P_j_i,P_F,P_M,P_X,P_E,P_V,P_W,TS)

size_holder = size(P_X);
num_of_samples = size_holder(1);

% Function Definitions
f1 = @(m,j,j_i,F,M,X,E,V,W) P_CB2E * P_V;
f2 = @(m,j,j_i,F,M,X,E,V,W) P_W2ED;
f3 = @(m,j,j_i,F,M,X,E,V,W) P_F / m - reshape(cross(P_W_r, reshape(P_V,3,num_of_samples)),size_holder(1),1);
f4 = @(m,j,j_i,F,M,X,E,V,W) P_j_i * (P_M - reshape(cross(P_W_r, reshape(P_j * P_W,3,num_of_samples)),size_holder(1),1));

% 4th Order Explicit Runge Kutta Integration
[X_NEW, E_NEW, V_NEW, W_NEW] = RK4(m,P_j,P_j_i,P_F,P_M,P_X,P_E,P_V,P_W,TS,f1,f2,f3,f4);

end
