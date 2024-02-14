function [x1,x2,x3,x4] = RK4(m,j,j_i,F,M,x1,x2,x3,x4,h,f1,f2,f3,f4)
  
  k1x1 = f1(m,j,j_i,F,M, x1,x2,x3,x4);
  k1x2 = f2(m,j,j_i,F,M, x1,x2,x3,x4);
  k1x3 = f3(m,j,j_i,F,M, x1,x2,x3,x4);
  k1x4 = f4(m,j,j_i,F,M, x1,x2,x3,x4);
  
  k2x1 = f1(m,j,j_i,F,M, x1+0.5*k1x1*h, x2+0.5*k1x2*h, x3+0.5*k1x3*h, x4+0.5*k1x4*h);
  k2x2 = f2(m,j,j_i,F,M, x1+0.5*k1x1*h, x2+0.5*k1x2*h, x3+0.5*k1x3*h, x4+0.5*k1x4*h);
  k2x3 = f3(m,j,j_i,F,M, x1+0.5*k1x1*h, x2+0.5*k1x2*h, x3+0.5*k1x3*h, x4+0.5*k1x4*h);
  k2x4 = f4(m,j,j_i,F,M, x1+0.5*k1x1*h, x2+0.5*k1x2*h, x3+0.5*k1x3*h, x4+0.5*k1x4*h);
  
  k3x1 = f1(m,j,j_i,F,M, x1+0.5*k2x1*h, x2+0.5*k2x2*h, x3+0.5*k2x3*h, x4+0.5*k2x4*h);
  k3x2 = f2(m,j,j_i,F,M, x1+0.5*k2x1*h, x2+0.5*k2x2*h, x3+0.5*k2x3*h, x4+0.5*k2x4*h);
  k3x3 = f3(m,j,j_i,F,M, x1+0.5*k2x1*h, x2+0.5*k2x2*h, x3+0.5*k2x3*h, x4+0.5*k2x4*h);
  k3x4 = f4(m,j,j_i,F,M, x1+0.5*k2x1*h, x2+0.5*k2x2*h, x3+0.5*k2x3*h, x4+0.5*k2x4*h);
  
  k4x1 = f1(m,j,j_i,F,M, x1+k3x1*h, x2+k3x2*h, x3+k3x3*h, x4+k3x4*h);
  k4x2 = f2(m,j,j_i,F,M, x1+k3x1*h, x2+k3x2*h, x3+k3x3*h, x4+k3x4*h);
  k4x3 = f3(m,j,j_i,F,M, x1+k3x1*h, x2+k3x2*h, x3+k3x3*h, x4+k3x4*h);
  k4x4 = f4(m,j,j_i,F,M, x1+k3x1*h, x2+k3x2*h, x3+k3x3*h, x4+k3x4*h);
   
  x1 = x1 + 1/6*(k1x1+2*k2x1+2*k3x1+k4x1)*h; 
  x2 = x2 + 1/6*(k1x2+2*k2x2+2*k3x2+k4x2)*h;  
  x3 = x3 + 1/6*(k1x3+2*k2x3+2*k3x3+k4x3)*h; 
  x4 = x4 + 1/6*(k1x4+2*k2x4+2*k3x4+k4x4)*h; 

end
