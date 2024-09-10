function C = CB2E_PARALLEL(E)

% Ensure inputs are gpuArrays
E = gpuArray(E);

% Extract components
E1 = E(:, 1); % Rotation about x-axis
E2 = E(:, 2); % Rotation about y-axis
E3 = E(:, 3); % Rotation about z-axis

% Precompute trigonometric functions
cosE1 = cos(E1); 
sinE1 = sin(E1);

cosE2 = cos(E2); 
sinE2 = sin(E2);

cosE3 = cos(E3); 
sinE3 = sin(E3);

% Initialize basic transformation matrices
N = size(E, 1);
CE2F = gpuArray.zeros(3, 3, N);
CF2S = gpuArray.zeros(3, 3, N);
CS2B = gpuArray.zeros(3, 3, N);

% Transformation between E(2) Earth frame and first intermediate frame
% Rotating about z-axis for E(3) radians

% CE2F = [ cosE3, sinE3, 0;
%         -sinE3, cosE3, 0;
%              0,     0, 1];

CE2F(1,1,:) = cosE3;
CE2F(1,2,:) = sinE3;
CE2F(2,1,:) = -sinE3;
CE2F(2,2,:) = cosE3;
CE2F(3,3,:) = gpuArray.ones(1, 1, N);


% Transformation between E(2) first and second intermatediate frames
% Rotating about y-axis for E(2) (E(2)ta) radians
% CF2S = [ cosE2, 0, -sinE2;
%              0, 1,      0;
%          sinE2, 0,  cosE2];

CF2S(1,1,:) = cosE2;
CF2S(1,3,:) = -sinE2;
CF2S(3,1,:) = sinE2;
CF2S(3,3,:) = cosE2;
CF2S(2,2,:) = gpuArray.ones(1, 1, N);

% Transformation between E(2) second intermediate frame and body frame
% Rotating about x-axis for E(1) radians
% CS2B = [ 1,         0,        0;
%          0,  cosE1, sinE1;
%          0, -sinE1, cosE1];

CS2B(2,2,:) = cosE1;
CS2B(2,3,:) = sinE1;
CS2B(3,2,:) = -sinE1;
CS2B(3,3,:) = cosE1;
CS2B(1,1,:) = gpuArray.ones(1, 1, N);

% Combination
C = pagefun(@mtimes, CE2F, pagefun(@mtimes, CF2S, CS2B));

end