function C = computeRotationMatrices(E)
    % Ensure E is a gpuArray if needed
    % E = gpuArray(E);

    % Extract components
    E1 = E(:, 1); % Rotation about x-axis
    E2 = E(:, 2); % Rotation about y-axis
    E3 = E(:, 3); % Rotation about z-axis

    % Precompute trigonometric functions
    cosE1 = cos(E1); sinE1 = sin(E1);
    cosE2 = cos(E2); sinE2 = sin(E2);
    cosE3 = cos(E3); sinE3 = sin(E3);

    % Initialize output matrix
    N = size(E, 1);
    C = zeros(3*N, 3);

    % Compute the rotation matrices
    for i = 1:N
        % Transformation between E(2) Earth frame and first intermediate frame
        % Rotating about z-axis for E(3) radians
        CE2F = [cosE3(i), sinE3(i), 0;
                -sinE3(i), cosE3(i), 0;
                0, 0, 1];

        % Transformation between E(2) first and second intermediate frames
        % Rotating about y-axis for E(2) radians
        CF2S = [cosE2(i), 0, -sinE2(i);
                0, 1, 0;
                sinE2(i), 0, cosE2(i)];

        % Transformation between E(2) second intermediate frame and body frame
        % Rotating about x-axis for E(1) radians
        CS2B = [1, 0, 0;
                0, cosE1(i), sinE1(i);
                0, -sinE1(i), cosE1(i)];

        % Combine the rotation matrices
        C((3*i-2):(3*i), :) = (CS2B * CF2S * CE2F)';
    end

    % If needed, gather results from GPU to CPU
    % C = gather(C);
end
