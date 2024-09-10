function C = parallelCE2B(E)
    % Ensure E is a gpuArray if needed
    E = gpuArray(E);

    % Extract Euler angles
    phi = E(:, 1);
    the = E(:, 2);
    psi = E(:, 3);

    % Precompute trigonometric functions
    sinPhi = sin(phi); 
    cosPhi = cos(phi);
    sinThe = sin(the); 
    cosThe = cos(the);
    sinPsi = sin(psi);
    cosPsi = cos(psi);

    % Initialize rotation matrix array
    N = size(E, 1);
    C = gpuArray.zeros(3, 3, N);

    % Populate the rotation matrices
    C(1, 1, :) = cosPsi .* cosThe;
    C(2, 1, :) = cosPsi .* sinThe .* sinPhi - sinPsi .* cosPhi;
    C(2, 1, :) = cosPsi .* sinThe .* cosPhi + sinPsi .* sinPhi;
    C(1, 2, :) = sinPsi .* cosThe;
    C(2, 2, :) = sinPsi .* sinThe .* sinPhi + cosPsi .* cosPhi;
    C(3, 2, :) = sinPsi .* sinThe .* cosPhi - cosPsi .* sinPhi;
    C(1, 3, :) = -sinThe;
    C(2, 3, :) = cosThe .* sinPhi;
    C(3, 3, :) = cosThe .* cosPhi;
end