function PLOTRESULTS(FIGNOS,TS,X,E,V,W)

% Time array calculation
t_arr = TS * (0:1:length(X(1,:)) - 1);

% Pose plots
figure(FIGNOS(1))
% Position plots
subplot(2,3,1), hold all, grid on, xlabel('Time [s]'), ylabel('X [m]')
plot(t_arr, X(1,:))
subplot(2,3,2), hold all, grid on, xlabel('Time [s]'), ylabel('Y [m]')
plot(t_arr, X(2,:))
subplot(2,3,3), hold all, grid on, xlabel('Time [s]'), ylabel('Z [m]')
plot(t_arr, X(3,:))
% Orientation plots
subplot(2,3,4), hold all, grid on, xlabel('Time [s]'), ylabel('Roll [rad]')
plot(t_arr, E(1,:))
subplot(2,3,5), hold all, grid on, xlabel('Time [s]'), ylabel('Pitch [rad]')
plot(t_arr, E(2,:))
subplot(2,3,6), hold all, grid on, xlabel('Time [s]'), ylabel('Yaw [rad]')
plot(t_arr, E(3,:))

% Velocity plots
figure(FIGNOS(2))
% Linear velocity plots
subplot(2,3,1), hold all, grid on, xlabel('Time [s]'), ylabel('Surge [m/s]')
plot(t_arr, V(1,:))
subplot(2,3,2), hold all, grid on, xlabel('Time [s]'), ylabel('Sway [m/s]')
plot(t_arr, V(2,:))
subplot(2,3,3), hold all, grid on, xlabel('Time [s]'), ylabel('Heave [m/s]')
plot(t_arr, V(3,:))
% Angular veloctiy plots
subplot(2,3,4), hold all, grid on, xlabel('Time [s]'), ylabel('P [rad/s]')
plot(t_arr, W(1,:))
subplot(2,3,5), hold all, grid on, xlabel('Time [s]'), ylabel('Q [rad/s]')
plot(t_arr, W(2,:))
subplot(2,3,6), hold all, grid on, xlabel('Time [s]'), ylabel('R [rad/s]')
plot(t_arr, W(3,:))

end