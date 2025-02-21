% Task 2

close all
clear all
clc

load 'mr_image.mat';

image = single(mrVolume(:, :, 90));

size_image = size(image);
center = (size_image + 1) / 2;

% Define transformation parameters
translation_x = 2.1;
translation_y = 0;
scaling_x = 1.1;
scaling_y = 1.0;
rotation_angles = -45:45;

% Calculate interpolation errors for different options
interpolation_types = ["nearest", "linear", "cubic"];

for plot_index = 1:length(interpolation_types)
    interpolation_type = interpolation_types(plot_index);
    image_ssds = zeros(size(rotation_angles));
    for i = 1:length(rotation_angles)
    % Define the transformations
    transformation_matrix = makeTransf_2D_center(rotation_angles(i), translation_x, translation_y, scaling_x, scaling_y, center);
    transformation_matrix_inverse = inv(transformation_matrix);

    % Transformations with nearest neighbor interpolation
    image_transformed = transform_image_2D(transformation_matrix, image, interpolation_type);
    image_backtransformed = transform_image_2D(transformation_matrix_inverse, image_transformed, interpolation_type);
    image_diff = image - image_backtransformed;
    image_ssds(i) = sum(image_diff(:).^2);
    end
    % Plot the pixel differences
    subplot(1, length(interpolation_types), plot_index);
    plot(rotation_angles, image_ssds)
    xlabel("Rotation Angles")
    ylabel("SSD")
    title(interpolation_type)
    grid on
end