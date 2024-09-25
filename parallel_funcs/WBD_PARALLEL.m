function WBD = WBD_PARALLEL(j, j_i, W, M)

N = size(W, 1);

% Ensure inputs are gpuArrays
% M = gpuArray(M);
% W = gpuArray(W);
% j = gpuArray(j);
% j_i = gpuArray(j_i);

% Reshape W for page-wise multiplication
M = reshape(M', 3, 1, N);
W = reshape(W', 3, 1, N);

% Compute ED using page-wise matrix multiplication
GYRO = CROSS_PARALLEL(W, pagefun(@mtimes, j, W));
WBD = pagefun(@mtimes, j_i, (M - GYRO));

% Reshape ED to the desired output format
WBD = reshape(WBD, 3, N)';

% Gather the result if needed
WBD = gather(WBD);

end