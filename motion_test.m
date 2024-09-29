%% Prep
% Start
clc, clear, close all

% Simulation parameters
t_s = 0.01;
t_lim = 0.4;
ns = 80;
nst = t_lim / t_s;

% Rigid body parameters
m = 1;
j = eye(3);
j_i = inv(j);

% Rigid body dimensions
dims = [0.5 , 0.5, 5];

% Allocation
X = zeros(3,t_lim/t_s);
E = zeros(3,t_lim/t_s);
V = zeros(3,t_lim/t_s);
W = zeros(3,t_lim/t_s);

% Initial conditions
X(:,1) = [2, 2, 2]';
E(:,1) = [0, pi/4, 0]';
V(:,1) = [0, 0, -80]';
W(:,1) = [0, 0, 0]';

%% Simulation
tic
for test_no = 1:ns
    step_counter = 0;
    for i = t_s:t_s:t_lim
    
        step_counter = step_counter + 1;
    
        F = [0, 0, 0]' + CE2B(E(:,step_counter)) * [0, 0, 9.81]';
        M = [0, 0, 0]';
    
        [X_NEW,E_NEW,V_NEW,W_NEW] = RK4UPDATESTATES(m,j,j_i,F,M,...
            X(:,step_counter),E(:,step_counter),V(:,step_counter), ...
            W(:,step_counter),t_s);
    
        X(:,step_counter + 1) = X_NEW;
        E(:,step_counter + 1) = ANGLEMAP(E_NEW);
        V(:,step_counter + 1) = V_NEW;
        W(:,step_counter + 1) = W_NEW;
    
        % if mod(step_counter, 1) == 0
        %     PLOTOBJECT(3, dims, X_NEW, E_NEW, 1)
        %     % pause(0.1)
        % end
        
    end
end
elapsed_time = toc;
display("---- CPU ----")
display(strcat("Elapsed time is ", num2str(elapsed_time), " seconds for ", num2str(ns), " samples of ", num2str(nst), " steps"))
display(strcat("Elapsed time is ", num2str(elapsed_time/t_lim), " simulation seconds per real seconds"))
display(strcat("Real time ratio is ", num2str(t_lim/elapsed_time)))
display(strcat("Controller time ratio is ", num2str(t_s/elapsed_time)))

%% Plot
% PLOTRESULTS([1,2],t_s,X,E,V,W)














