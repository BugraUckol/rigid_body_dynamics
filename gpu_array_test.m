addpath('parallel_funcs')

N = 10000;
step = 100;

Q = 1:step:N;
TGE = zeros(N/step, 1);
TE = zeros(N/step, 1);

idx = 0;
for i = Q

    idx = idx + 1;

    GE = gpuArray.rand(i, 3);
    E = rand(N, 3);
    
    % Call the function in GPU
    tic
    GC = CE2B_PARALLEL(GE);
    GC = CB2E_PARALLEL(GE);
    TGE(idx) = toc;
    
    % Call the function in CPU
    C = zeros(3,3,i);
    tic
    for j = 1:i
        C(:,:,j) = CB2E(E(j,:));
        C(:,:,j) = CE2B(E(j,:));
    end
    TE(idx) = toc;

end

figure, hold all
plot(Q, TE);
plot(Q, TGE);
title('Rotation Matrix Calculation Time')
xlabel('Number of Process')
ylabel('Time [ms]')
grid minor
legend('CPU', 'GPU')

rmpath('parallel_funcs')