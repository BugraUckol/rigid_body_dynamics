%% Prep
% Start
clc, clear, close all

% Simulation parameters
t_s = 0.01;
t_lim = 0.4;
ns = 40; % Number of samples
nst = t_lim / t_s;

% Rigid body parameters
m = 1;
j = eye(3);
j_i = inv(j);

% Rigid body dimensions
dims = [0.5 , 0.5, 5];

% Allocation
X = zeros(ns, 3, t_lim/t_s);
E = zeros(ns, 3, t_lim/t_s);
V = zeros(ns, 3, t_lim/t_s);
W = zeros(ns, 3, t_lim/t_s);

% Initial conditions
P_X(:,:) = gpuArray(repmat([2, 2, 2],ns,1));
P_E(:,:) = gpuArray(repmat([0, pi/4, 0],ns,1));
P_V(:,:) = gpuArray(repmat([0, 0, -80],ns,1));
P_W(:,:) = gpuArray(repmat([0, 0, 0],ns,1));

% GPU allocations
P_F = zeros(ns,  3, "gpuArray");
P_M = zeros(ns , 3, "gpuArray");
P_j = gpuArray(repmat(j,1,1,ns));
P_j_i = gpuArray(repmat(j^-1,1,1,ns));

%% Simulation - GPU
step_counter = 0;
tic
for i = t_s:t_s:t_lim-t_s
    step_counter = step_counter + 1;
    [P_X(:,:), P_E(:,:), ...
        P_V(:,:), P_W(:,:)] = ...
        PARALLELRK4UPDATESTATES(m,P_j,P_j_i,P_F,P_M,P_X,P_E,P_V,P_W,t_s);

    X(:,:,step_counter) = gather(P_X(:,:));
    E(:,:,step_counter) = gather(P_E(:,:));
    V(:,:,step_counter) = gather(P_V(:,:));
    W(:,:,step_counter) = gather(P_W(:,:));
end
elapsed_time = toc;
display("---- GPU ----")
display(strcat("Elapsed time is ", num2str(elapsed_time), " seconds for ", num2str(ns), " samples of ", num2str(nst), " steps"))
display(strcat("Elapsed time is ", num2str(elapsed_time/ns), " seconds per sample"))

%% Plot
% PLOTRESULTS([1,2],t_s,X,E,V,W)














