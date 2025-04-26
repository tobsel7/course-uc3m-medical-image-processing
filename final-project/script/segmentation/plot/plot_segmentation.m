% Displays a summary of an im
function plot_segmentation(image, mask, pixel_size)
    % Get the index for the middle of each slice
    mid_x = round(size(image, 1) / 2);
    mid_y = round(size(image, 2) / 2);
    mid_z = round(size(image, 3) / 2);

    % Choose the image slices
    axial_img = squeeze(image(:, :, mid_z));
    sagittal_img = squeeze(image(mid_x, :, :))';
    coronal_img = squeeze(image(:, mid_y, :))';

    % Choose the corresponding mask slices
    axial_mask = squeeze(mask(:, :, mid_z));
    sagittal_mask = squeeze(mask(mid_x, :, :))';
    coronal_mask = squeeze(mask(:, mid_y, :))';

    % Calculate pixel size ratios
    aspect_xy = [pixel_size(2) / pixel_size(1), 1];
    aspect_xz = [pixel_size(3) / pixel_size(1), 1];
    aspect_yz = [pixel_size(3) / pixel_size(2), 1];

    % Row 1: Original image
    subplot(3,3,1);
    imshow(axial_img, []); axis image off; daspect([aspect_xy 1]);
    title("Axial: Original");

    subplot(3,3,2);
    imshow(coronal_img, []); axis image off; daspect([aspect_yz 1]);
    title("Coronal: Original");

    subplot(3,3,3);
    imshow(sagittal_img, []); axis image off; daspect([aspect_xz 1]);
    title("Sagittal: Original");

    % Row 2: Segmentation mask
    subplot(3,3,4);
    imshow(axial_mask, []); axis image off; daspect([aspect_xy 1]);
    title("Axial: Segmentation");

    subplot(3,3,5);
    imshow(coronal_mask, []); axis image off; daspect([aspect_yz 1]);
    title("Coronal: Segmentation");

    subplot(3,3,6);
    imshow(sagittal_mask, []); axis image off; daspect([aspect_xz 1]);
    title("Sagittal: Segmentation");

    % Row 3: Original with colored segmentation mask
    subplot(3,3,7);
    overlay_image(axial_img, axial_mask, aspect_xy);
    title("Axial: Image + Mask");

    subplot(3,3,8);
    overlay_image(coronal_img, coronal_mask, aspect_yz);
    title("Coronal: Image + Mask");

    subplot(3,3,9);
    overlay_image(sagittal_img, sagittal_mask, aspect_xz);
    title("Sagittal: Image + Mask");
end
