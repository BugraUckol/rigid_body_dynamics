%% Prep
% Start
clc, clear, close all

% Simulation parameters
t_s = 0.001;
t_lim = 50;

% Rigid body parameters
m = 1;
j = eye(3);
j_i = inv(j);

% Rigid body dimensions
dims = [0.8 , 0.8, 0.05];

% Allocation
X = zeros(3,t_lim/t_s);
E = zeros(3,t_lim/t_s);
V = zeros(3,t_lim/t_s);
W = zeros(3,t_lim/t_s);

% Initial conditions
X(:,1) = [1, 1, 1]';
E(:,1) = [0, pi/4, pi/4]';
V(:,1) = [0, 0, 0.1]';
W(:,1) = [0, 0, 0.2]';

%% Simulation
step_counter = 0;
for i = t_s:t_s:t_lim

    step_counter = step_counter + 1;

    F = [0, 0, 0]';
    M = [0, 0, 0]';

    [X_NEW,E_NEW,V_NEW,W_NEW] = RK4UPDATESTATES(m,j,j_i,F,M,...
        X(:,step_counter),E(:,step_counter),V(:,step_counter), ...
        W(:,step_counter),t_s);

    X(:,step_counter + 1) = X_NEW;
    E(:,step_counter + 1) = ANGLEMAP(E_NEW);
    V(:,step_counter + 1) = V_NEW;
    W(:,step_counter + 1) = W_NEW;

    if mod(step_counter, 1000) == 0
        PLOTOBJECT(3, dims, X_NEW, E_NEW, 0)
        % pause(0.1)
    end
    
end

%% Plot
PLOTRESULTS([1,2],t_s,X,E,V,W)














