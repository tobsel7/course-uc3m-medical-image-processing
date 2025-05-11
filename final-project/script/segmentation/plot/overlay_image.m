function overlay_image(image, mask, aspect)
    % Normalize the image
    image = double(image);
    image = (image - min(image(:))) / (max(image(:)) - min(image(:)) + eps);

    % Create RGB image from grayscale
    rgb = repmat(image, [1, 1, 3]);

    % Color the mask red
    red = cat(3, ones(size(image)), zeros(size(image)), zeros(size(image)));
    rgb(mask > 0) = red(mask > 0);

    % Display the image
    imshow(rgb);
    axis image off;
    daspect([aspect 1]);
end