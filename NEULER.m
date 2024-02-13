function [VD, WD] = NEULER(m,j,j_i,F,M,V,W)

VD = F / m - cross(W, V);
WD = j_i * (M - cross(W, j * W));

end