function VBD = VBD_PARALLEL(m, F, V, W)

N = size(F, 1);

% Ensure inputs are gpuArrays
F = gpuArray(F);
W = gpuArray(W);
V = gpuArray(V);

% Reshape W for page-wise multiplication
F = reshape(F', 3, 1, N);
V = reshape(V', 3, 1, N);
W = reshape(W', 3, 1, N);

% Compute ED using page-wise matrix multiplication
corilois = CROSS_PARALLEL(W, V);
VBD = F ./ m - corilois;

% Reshape ED to the desired output format
VBD = reshape(VBD, 3, N)';

% Gather the result if needed
VBD = gather(VBD);

end