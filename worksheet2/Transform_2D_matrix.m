function p_transformed = Transform_2D_matrix(Tr,p)

[N_puntos,aux] = size(p); 
p_Homogeneous = [[p],ones(N_puntos,1)];
p_tr_Homogeneous = Tr*p_Homogeneous';
p_transformed = (p_tr_Homogeneous(1:2,:))';

end