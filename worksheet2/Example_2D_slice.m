%% Transformation example

close all
clear all
clc

load 'mr_image.mat'

% mr_image.mat is a file containing a single matlab variable named mrVolume,
% that is a 3D Magnetic Resonance image

image = single(mrVolume(:,:,90)); % Use this line to work with one slice from the 3D MR image

% Image center will be the origin of the transformations
size_image=size(image);
center = (size_image+1)/2; 

% Transformation matrix
Tr = makeTransf_2D_center(45,0,0,1,1,center);

% Three images are interpolated, every one with a different interpolation
% method
image_transf_NN = transform_image_2D(Tr,image,'nearest');
image_transf_LIN = transform_image_2D(Tr,image,'linear');
image_transf_CUB = transform_image_2D(Tr,image,'cubic');

% Subplot command allows displaying the original and 3 transformed images
% in a single figure
figure
subplot(2,2,1)
imshow(image,[]);
title('Original')
subplot(2,2,2)
imshow(image_transf_NN,[]);
title('Rotated (nearest neighbour)')
subplot(2,2,3)
imshow(image_transf_LIN,[]);
title('Rotated (linear interpolation)')
subplot(2,2,4)
imshow(image_transf_CUB,[]);
title('Rotated (cubic interpolation)')

