function PLOTOBJECT(FIGNO, DIMS, X, E, CLF)
% Take dimensions
W = DIMS(1);
D = DIMS(2);
H = DIMS(3);

% Create corner locations of the bottom
C1 = [-W/2, -D/2, -H/2]';
C2 = [ W/2, -D/2, -H/2]';
C3 = [ W/2,  D/2, -H/2]';
C4 = [-W/2,  D/2, -H/2]';

BOTTOM = [C1, C2, C3, C4];

% Create upper locations
UP = BOTTOM + [0, 0, H]';

% Create center locations
CENT = zeros(3, 3);
TIPS = eye(3);

% Convert to homogenous coordinates
BOTTOMH = [BOTTOM; 1, 1, 1, 1];
UPH = [UP; 1, 1, 1, 1];
CENTH = [CENT; 1, 1, 1];
TIPSH = [TIPS; 1, 1, 1];

% Create the homogenous transformation matrix
R = [CB2E(E), X; 0, 0, 0, 1];

% Transform edge locations
BOTTOMHT = R * BOTTOMH;
UPHT = R * UPH;
CENTHT = R * CENTH;
TIPSHT = R * TIPSH;

% Transformed coordinates
BOTTOMT = BOTTOMHT(1:3,:);
UPT = UPHT(1:3,:);
CENTT = CENTHT(1:3,:);
TIPST = TIPSHT(1:3,:);

% Plot
figure(FIGNO)
if CLF
    clf
end
hold all

% Plot Earth frames
plot3([0,1],[0,0],[0,0],'r','LineWidth',2);
plot3([0,0],[0,1],[0,0],'g','LineWidth',2);
plot3([0,0],[0,0],[0,1],'b','LineWidth',2);

% Plot Body frame
plot3([CENTT(1,1), TIPST(1,1)], [CENTT(2,1), TIPST(2,1)],...
    [CENTT(3,1), TIPST(3,1)], 'r','LineWidth',2);
plot3([CENTT(1,2), TIPST(1,2)], [CENTT(2,2), TIPST(2,2)],...
    [CENTT(3,2), TIPST(3,2)], 'g','LineWidth',2);
plot3([CENTT(1,3), TIPST(1,3)], [CENTT(2,3), TIPST(2,3)],...
    [CENTT(3,3), TIPST(3,3)], 'b','LineWidth',2);

% Plot body
E1 = [BOTTOMT(:,1),UPT(:,1)]';
E2 = [BOTTOMT(:,2),UPT(:,2)]';
E3 = [BOTTOMT(:,3),UPT(:,3)]';
E4 = [BOTTOMT(:,4),UPT(:,4)]';

plot3(E1(:,1), E1(:,2), E1(:,3),'k','LineWidth',2);
plot3(E2(:,1), E2(:,2), E2(:,3),'k','LineWidth',2);
plot3(E3(:,1), E3(:,2), E3(:,3),'k','LineWidth',2);
plot3(E4(:,1), E4(:,2), E4(:,3),'k','LineWidth',2);

patch(UPT(1,:),UPT(2,:),UPT(3,:),'red')
patch(BOTTOMT(1,:),BOTTOMT(2,:),BOTTOMT(3,:),'green')

daspect([1,1,1]), grid on
title('Rigid Body','FontSize',18,'FontWeight','bold')
xlabel('X [m]','FontSize',12,'FontWeight','bold')
ylabel('Y [m]','FontSize',12,'FontWeight','bold')
view(-45,45)

end