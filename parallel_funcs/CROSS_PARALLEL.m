function [CROSS] = CROSS_PARALLEL(V1, V2)
    % Ensure inputs are gpuArrays
    V1 = gpuArray(V1);
    V2 = gpuArray(V2);

    % Extract Euler angles
    a1 = V1(1, 1, :);
    a2 = V1(2, 1, :);
    a3 = V1(3, 1, :);

    % Initialize transformation matrix SSM
    N = max(size(V2));
    V1_SSM = gpuArray.zeros(3, 3, N);
    
    % Populate the transformation matrices
    V1_SSM(1, 2, :) = -a3;
    V1_SSM(1, 3, :) = a2;
    V1_SSM(2, 1, :) = a3;
    V1_SSM(2, 3, :) = -a1;
    V1_SSM(3, 1, :) = -a2;
    V1_SSM(3, 2, :) = a1;

    % Compute ED using page-wise matrix multiplication
    CROSS = pagefun(@mtimes, V1_SSM, V2);
    
    % Gather the result if needed
    CROSS = gather(CROSS);
end
