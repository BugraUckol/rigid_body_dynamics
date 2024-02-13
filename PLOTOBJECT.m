function PLOTOBJECT(FIGNO, DIMS, X, E);
% Take dimensions
W = DIMS(1);
D = DIMS(2);
H = DIMS(3);

% Create corner locations of the bottom
E1 = [-W/2, -D/2, H/2]';
E2 = [ W/2, -D/2, H/2]';
E3 = [ W/2,  D/2, H/2]';
E4 = [-W/2,  D/2, H/2]';

BOTTOM = [E1, E2, E3, E4];

% Create upper locations
UP = BOTTOM + [0, 0, -H]';

% Convert to homogenous coordinates
BOTTOMH = [BOTTOM; 1, 1, 1, 1];
UPH = [UP; 1, 1, 1, 1];

% Create the homogenous transformation matrix
R = [CB2E(E), X; 0, 0, 0, 1];

% Transform edge locations
BOTTOMHT = R * BOTTOMH;
UPHT = R * UPH;

% Transformed bottom coordinates
BOTTOMT = BOTTOMHT(1:3,:);
UPT = UPHT(1:3,:);

figure(FIGNO), hold all %,clf

plot3(BOTTOMT(1,1),BOTTOMT(2,1),BOTTOMT(3,1),'o');
plot3(BOTTOMT(1,2),BOTTOMT(2,2),BOTTOMT(3,2),'o');
plot3(BOTTOMT(1,3),BOTTOMT(2,3),BOTTOMT(3,3),'o');
plot3(BOTTOMT(1,4),BOTTOMT(2,4),BOTTOMT(3,4),'o');

plot3(UPT(1,1),UPT(2,1),UPT(3,1),'o');
plot3(UPT(1,2),UPT(2,2),UPT(3,2),'o');
plot3(UPT(1,3),UPT(2,3),UPT(3,3),'o');
plot3(UPT(1,4),UPT(2,4),UPT(3,4),'o');

patch(UPT(1,:),UPT(2,:),UPT(3,:),'red')
patch(BOTTOMT(1,:),BOTTOMT(2,:),BOTTOMT(3,:),'green')

daspect([1,1,1]), grid on
xlabel('X [m]')
ylabel('Y [m]')
view(-45,45)

end