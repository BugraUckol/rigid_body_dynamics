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

figure(FIGNO)
if CLF
    clf
end
hold all

E1 = [BOTTOMT(:,1),UPT(:,1)]';
E2 = [BOTTOMT(:,2),UPT(:,2)]';
E3 = [BOTTOMT(:,3),UPT(:,3)]';
E4 = [BOTTOMT(:,4),UPT(:,4)]';

plot3(E1(:,1), E1(:,2), E1(:,3),'k');
plot3(E2(:,1), E2(:,2), E2(:,3),'k');
plot3(E3(:,1), E3(:,2), E3(:,3),'k');
plot3(E4(:,1), E4(:,2), E4(:,3),'k');

patch(UPT(1,:),UPT(2,:),UPT(3,:),'red')
patch(BOTTOMT(1,:),BOTTOMT(2,:),BOTTOMT(3,:),'green')

daspect([1,1,1]), grid on
title('Rigid Body','FontSize',18,'FontWeight','bold')
xlabel('X [m]','FontSize',12,'FontWeight','bold')
ylabel('Y [m]','FontSize',12,'FontWeight','bold')
view(-45,45)

end