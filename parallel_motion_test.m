%% Prep
% Start
clc, clear, close all

% Simulation parameters
t_s = 0.01;
t_lim = 1;
ns = 100; % Number of samples

% Rigid body parameters
m = 1;
j = eye(3);
j_i = inv(j);

% Rigid body dimensions
dims = [0.5 , 0.5, 5];

% Allocation
% X = zeros(3 * ns, t_lim/t_s);
% E = zeros(3 * ns, t_lim/t_s);
% V = zeros(3 * ns, t_lim/t_s);
% W = zeros(3 * ns, t_lim/t_s);

% Initial conditions
P_X(:,:) = gpuArray(repmat([2, 2, 2],ns,1));
P_E(:,:) = gpuArray(repmat([0, pi/4, 0],ns,1));
P_V(:,:) = gpuArray(repmat([0, 0, -80],ns,1));
P_W(:,:) = gpuArray(repmat([0, 0, 0],ns,1));

% GPU allocations
P_F = zeros(3,  ns, "gpuArray");
P_M = zeros(3 , ns, "gpuArray");
P_j = gpuArray(repmat(j,ns,ns));
P_j_i = gpuArray(repmat(j^-1,ns,ns));
P_CB2E = zeros(3 * ns, 3, "gpuArray");
P_W2ED = zeros(ns, 3, "gpuArray");

%% Simulation
step_counter = 0;
tic
for i = t_s:t_s:t_lim-t_s
    step_counter = step_counter + 1;

    F = [0, 0, 0]; %+ CE2B(E(:,step_counter)) * [0, 0, 9.81]';
    M = [0, 0, 0];

    size_holder = size(P_X);
    num_of_samples = ns;

    % P_W2ED = zeros(size_holder(1),1,"gpuArray");
    % P_CB2E = zeros(size_holder(1),"gpuArray");
    
    % for k = 1:num_of_samples
        % P_CB2E(3*(k-1)+1:3*(k-1)+3, 3*(k-1)+1:3*(k-1)+3) = CB2E(E);
        % P_W2ED(3*(k-1)+1:3*(k-1)+3, 1) = W2ED(W, E);
    % end

    P_CB2E = computeRotationMatrices(P_E);
    P_W2ED = parallelW2ED(P_W, P_E);

    [P_X(:,step_counter + 1), P_E(:,step_counter + 1), ...
        P_V(:,step_counter + 1), P_W(:,step_counter + 1)] = ...
        PARALLELRK4UPDATESTATES(P_CB2E,P_W2ED,m,P_j,P_j_i,P_F,P_M,...
        P_X(:,step_counter),P_E(:,step_counter),P_V(:,step_counter), ...
        P_W(:,step_counter),t_s);

    % E = P_E(3 * (step_counter) + 1 : 3 * (step_counter) + 3, step_counter + 1);
    % W = P_W(3*(step_counter) + 1 : 3*(step_counter)+3, step_counter + 1);

    % if mod(step_counter, 100) == 0
    %     PLOTOBJECT(3, dims, X_NEW(1:3), E_NEW(1:3), 1)
    %     % pause(0.1)
    % end
end
elapsed_time = toc;
display(strcat("Elapsed time is ", num2str(elapsed_time/ns), " seconds per sample"))

%% Plot
% PLOTRESULTS([1,2],t_s,X,E,V,W)














