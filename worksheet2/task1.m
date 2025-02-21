% Task 1

close all
clear all
clc

load 'mr_image.mat';

image = single(mrVolume(:, :, 90));

size_image = size(image);
center = (size_image + 1) / 2;

rotation_angles = -150:3:150;

% Initialize result
image_ssds_rotation = zeros(size(rotation_angles));
for i = 1:length(rotation_angles)
    % Rotate the image
    transformation_matrix = makeTransf_2D_center(rotation_angles(i), 0, 0, 1, 1, center);
    image_transformed = transform_image_2D(transformation_matrix, image, "linear");
    
    % Calculate the pixel differences
    image_diff = image - image_transformed;
    image_ssds_rotation(i) = sum(image_diff(:).^2);
end

subplot(1, 3, 1);
plot(rotation_angles, image_ssds_rotation)
xlabel("Rotation Angles")
ylabel("SSD")
title("Rotation")
grid on

translation_distances = -150:1:150;

% Initialize result
image_ssds_translation = zeros(size(translation_distances));
for i = 1:length(translation_distances)
    % Translate the image always by 1 (x^2 + y^2 = translation_distance^2 where x = y)
    translation_x = sqrt(1 / 2) * translation_distances(i);
    translation_y = sqrt(1 / 2) * translation_distances(i);
    transformation_matrix = makeTransf_2D_center(0, translation_x, translation_y, 1, 1, center);
    image_transformed = transform_image_2D(transformation_matrix, image, "linear");
    
    % Calculate the pixel differences
    image_diff = image - image_transformed;
    image_ssds_translation(i) = sum(image_diff(:).^2);
end

subplot(1, 3, 2);
plot(translation_distances, image_ssds_translation)
xlabel("Translation distance")
ylabel("SSD")
title("Translation")
grid on

scaling_factors = 0.1:0.1:5;

% Initialize result
image_ssds_scaling = zeros(size(scaling_factors));
for i = 1:length(scaling_factors)
    % Scale both dimensions equally by a factor
    transformation_matrix = makeTransf_2D_center(0, 0, 0, scaling_factors(i), scaling_factors(i), center);
    image_transformed = transform_image_2D(transformation_matrix, image, "linear");
    
    % Calculate the pixel differences
    image_diff = image - image_transformed;
    image_ssds_scaling(i) = sum(image_diff(:).^2);
end

subplot(1, 3, 3);
plot(scaling_factors, image_ssds_scaling)
xlabel("Scaling factor")
ylabel("SSD")
title("Scaling")
grid on