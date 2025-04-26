% Segments an image using the otsu method by emplyoing the method
% `otsu_threshold`
function segmentation_mask = otsu_segmentation(image)
   % Calculate histogram
    n_bins = 200; % Arbitrary value, the higher the more accurate
    [bin_counts, bin_edges] = create_histogram(image, n_bins);

    % Determine the threshold for the segmentation
    threshold = bin_edges(otsu_threshold(bin_counts));
    % Mark all pixels surpassing the threshold value
    segmentation_mask = image > threshold;
end