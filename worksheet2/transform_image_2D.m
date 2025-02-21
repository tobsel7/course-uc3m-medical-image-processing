function image_new = transform_image_2D (Tr,image, interp_type)

[M,N] = size(image);

% Inverse Matrix necessary for the interpolation
Tr_inv = inv(Tr);

[X,Y] = meshgrid(1:N,1:M);

points_transf_inv = Transform_2D_matrix(Tr_inv,[X(:),Y(:)]);

X_transf_inv = reshape(points_transf_inv (:,1),size(X));
Y_transf_inv = reshape(points_transf_inv (:,2),size(Y));

% Interpolation is performed
image_new = interp2(image,X_transf_inv,Y_transf_inv,interp_type);
image_new(isnan(image_new)) = 0;

end