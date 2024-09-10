function [ED] = W2ED_PARALLEL(W, E)
    % Ensure inputs are gpuArrays
    W = gpuArray(W);
    E = gpuArray(E);

    % Extract Euler angles
    phi = E(:, 1);
    the = E(:, 2);

    % Precompute trigonometric functions
    sinPhi = sin(phi); 
    cosPhi = cos(phi);
    tanThe = tan(the); 
    secThe = sec(the);

    % Initialize transformation matrix H
    N = size(E, 1);
    H = gpuArray.zeros(3, 3, N);
    
    % Populate the transformation matrices
    H(1, 1, :) = 1;
    H(1, 2, :) = sinPhi .* tanThe;
    H(1, 3, :) = cosPhi .* tanThe;
    H(2, 2, :) = cosPhi;
    H(2, 3, :) = -sinPhi;
    H(3, 2, :) = sinPhi .* secThe;
    H(3, 3, :) = cosPhi .* secThe;

    % Reshape W for page-wise multiplication
    W = reshape(W', 3, 1, N);

    % Compute ED using page-wise matrix multiplication
    ED = pagefun(@mtimes, H, W);
    
    % Reshape ED to the desired output format
    ED = reshape(ED, 3, N)';
    
    % Gather the result if needed
    ED = gather(ED);
end
