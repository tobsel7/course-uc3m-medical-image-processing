clc
clear

% The image must be in the same folder as the script
file_id = fopen('data/IM_0069_rot.raw');

% Define matrix properties
matrix_size = [512, 512]; % Matrix size
im2 = fread(file_id, matrix_size, 'int16', 'ieee-be'); % Read image with big-endian format

% Display the raw image
figure
imshow(im2, [])
title('Raw Image')
colorbar % Display intensity values
hold on

% Calculate pixel size
FOV = 614.4;
mat_size_pixel = matrix_size(1,1);
pixel_size = FOV / mat_size_pixel;

% Define the region of interest (ROI) coordinates
pixel_number = 24 / pixel_size; % Convert 24mm to pixels
x_coords = [210, 210 + pixel_number]; % X-coordinates
y_coords = [180, 180 + pixel_number]; % Y-coordinates

% Mark the ROI on the image
rectangle('Position', [y_coords(1), x_coords(1), pixel_number, pixel_number], ...
          'EdgeColor', 'r', 'LineWidth', 2); % the rectangle function interprets the coordinates differently

% Extract the ROI for noise calculation
ROI = im2(x_coords(1):x_coords(2), y_coords(1):y_coords(2));
standard_deviation = std(ROI(:));
mean_value = mean(ROI(:));
cv = standard_deviation / mean_value;

% Approach I: Loop-based subsampling
sub1 = zeros(256);
fprintf('First approach\n')
tic;
for i = 1:256
    for j = 1:256
        sub1(i, j) = (im2((i-1)*2+1, (j-1)*2+1) + im2((i-1)*2+2, (j-1)*2+1) + ...
                      im2((i-1)*2+1, (j-1)*2+2) + im2((i-1)*2+2, (j-1)*2+2)) / 4;
    end
end
toc;

% Display subsampled image (Approach 1)
figure
imshow(sub1, [])
title('Subsampled Image - Approach 1')
colorbar

% Approach II: Vectorized subsampling
fprintf('\nSecond approach\n')
tic;
rows = 1:2:size(im2, 1);
cols = 1:2:size(im2, 2);
sub2 = (im2(rows, cols) + im2(rows, cols+1) + im2(rows+1, cols) + im2(rows+1, cols+1)) / 4;
toc;

% Display subsampled image (Approach 2)
figure
imshow(sub2, [])
title('Subsampled Image - Approach 2')
colorbar
hold on

% Update pixel size for subsampled image
mat_size_pixel = 256;
pixel_size = FOV / mat_size_pixel;
pixel_number = 24 / pixel_size;

% Extract ROI for noise calculation in subsampled image (Approach 2)
ROI_subsampled = sub2(x_coords(1)/2 : x_coords(2)/2, y_coords(1)/2 : y_coords(2)/2);

% Calculate standard deviation and mean of the subsampled ROI
std_subsampled = std(ROI_subsampled(:));
mean_subsampled = mean(ROI_subsampled(:));
cv_sub = std_subsampled / mean_subsampled;
fprintf('\nNoise Calculation:\n');
fprintf('Original Image Noise: %f\n', cv);
fprintf('Subsampled Image Noise: %f\n', cv_sub);

% Calculate noise reduction ratio
noise_reduction_ratio = (cv - cv_sub) / cv;
fprintf('Noise Reduction Ratio: %f\n', noise_reduction_ratio);