function Tr = makeTransf_2D_center(angle,tx,ty,sx,sy,center)

R = [cosd(angle) sind(angle) 0; -sind(angle) cosd(angle) 0; 0 0 1];
T = [1 0 tx; 0 1 ty; 0 0 1];
S = [sx 0 0; 0 sy 0; 0 0 1];

T_center = [1 0 -center(2); 0 1 -center(1); 0 0 1];
T_center_inv = [1 0 center(2); 0 1 center(1); 0 0 1];

Tr = T_center_inv*S*R*T*T_center;

end