function overlay_image(image, mask, aspect)
    % Normalize the image
    image = double(image);
    image = (image - min(image(:))) / (max(image(:)) - min(image(:)) + eps);

    % Create RGB image from grayscale
    rgb = repmat(image, [1, 1, 3]);
    red = [1, 0, 0];

    % Color the mask red
    for c = 1:3
        channel = rgb(:, :, c);
        channel(mask > 0) = red(c);
        rgb(:, :, c) = channel;
    end

    % Display the image
    imshow(rgb);
    axis image off;
    daspect([aspect 1]);
end