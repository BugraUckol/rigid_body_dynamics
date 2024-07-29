function C = CB2E(E)

% Transformation between E(2) Earth frame and first intermediate frame
% Rotating about z-axis for E(3) radians
CE2F = [ cos(E(3)), sin(E(3)), 0;
        -sin(E(3)), cos(E(3)), 0;
                0,        0, 1];

% Transformation between E(2) first and second intermatediate frames
% Rotating about y-axis for E(2) (E(2)ta) radians
CF2S = [ cos(E(2)), 0, -sin(E(2));
                0, 1,         0;
         sin(E(2)), 0,  cos(E(2))];

% Transformation between E(2) second intermediate frame and body frame
% Rotating about x-axis for E(1) radians
CS2B = [ 1,         0,        0;
         0,  cos(E(1)), sin(E(1));
         0, -sin(E(1)), cos(E(1))];

% Combination
C = (CS2B * CF2S * CE2F)';

end